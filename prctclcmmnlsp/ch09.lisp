;;
;; Chapter 09: Practical: Building a Unit Test Framework
;;

;;
;; Warm ups
;;
(setf ll (loop for i below 5 collect i))

(defmacro echo (f)
  `(format t "~a: ~a" ,f ',f))

(defmacro isprime (n)
  `(format t "~:[PRIME~;Non-PRIME~] ~a" (not (primep ,n)) ,n))

;;
;;
(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result)

;;
;; Final forms
;;
(defvar *test-name* nil)

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))

(defmacro check (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
		`(let ((,result t))
		   ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
		   ,result)))

;;
;; experiments, ideas
;;
(defmacro f1 ()
  `(progn (defun foo()
	    (format t "I am foo from f1"))
	  (foo)))


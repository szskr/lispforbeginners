;;
;; Chapter 09: Practical: Building a Unit Test Framework
;;


(nl)
(chap09)
(comment "Chapter 09")
(nl)

;;;
;;;
;;;
(format t "(= (+ 1 2) 3 ) = ~a~%" (= (+ 1 2) 3))
(format t "(= (+ 1 2) 4 ) = ~a~%" (= (+ 1 2) 4))
(nl)

;;;
;;; Two First  Tries
;;;
(defun test-+.01 ()
  (and
   (= (+ 1 2) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -4)))

(format t "(test-+.01) = ~a~%" (test-+.01))
(nl)

(defun test-+.02 ()
  (format t "~:[FAIL~;pass~] ... ~a~%" (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (format t "~:[FAIL~;pass~] ... ~a~%" (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
  (format t "~:[FAIL~;pass~] ... ~a~%" (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))

(format t "(test-+.02) = ~%")
(test-+.02)
(nl)

;;;
;;; Refactoring
;;;
(defun report-result-01 (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form))

(defun test-+.03 ()
  (report-result-01 (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (report-result-01 (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
  (report-result-01 (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))

(format t "(test-+.03) = ~%")
(test-+.03)
(nl)

(defmacro check-01 (form)
  `(report-result-01 ,form ',form))

(format t "(check-01 (= (+ 1 2) 3)) = ~%")
(check-01 (= (+ 1 2) 3))
(nl)

(format t "(macroexpand-1 '(check-01 (= (+ 1 2) 3))) = ~%  ~a" (macroexpand-1 '(check-01 (= (+ 1 2) 3))))
(nl)

(defun test-+.04 ()
  (check-01 (= (+ 1 2) 3))
  (check-01 (= (+ 1 2 3) 6))
  (check-01 (= (+ -1 -3) -4)))

(nl)
(format t "(test-+.04) = ~%")
(test-+.04)
(nl)

(defmacro check-02 (&body forms)
  `(progn
    ,@(loop for f in forms collect `(report-result-01 ,f ',f))))

(format t "(macroexpand-1 '(check-02 (= (+ 1 2) 3) (= (+ 1 2 3) 6))) = ~%  ~a"
	(macroexpand-1 '(check-02 (= (+ 1 2) 3) (= (+ 1 2 3) 6))))
(nl)

(defun test-+.05 ()
  (check-02
   (= (+ 1 2) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -4)))

(nl)
(format t "(test-+.05) = ~%")
(test-+.05)
(nl)

;;;
;;; Fixing the Return Value
;;;
(defun report-result-02 (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result)

(defmacro combine-results (&body forms)
  (with-gensyms-1 (result)
		`(let ((,result t))
		   ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
		   ,result)))

(defmacro check-03 (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result-02 ,f ',f))))

(defun test-+.06 ()
  (check-03
   (= (+ 1 2) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -1)))

(format t "(test-+.06 = ~%")
(test-+.06)
(nl)

(defun test*.01 ()
  (check-03
   (= (* 2 3) 6)
   (= (* 3 5) 15)))

(format t "test*.01 = ~%")
(test*.01)
(nl)

(defun test-arithmatic-01 ()
  (combine-results
   (test-+.06)
   (test*.01)))

(format t "(test-arithmatic-01) = ~%")
(test-arithmatic-01)
		
;;;
;;; Better Result Reporting
;;;
(defvar *test-name* nil)

(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ...~a: ~a~%" result *test-name* form)
  result)

(defmacro check (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))

(defun test-+ ()
  (let ((*test-name* 'test-+))
    (check
     (= (+ 1 2) 3)
     (= (+ 1 2 3) 6)
     (= (+ -1 -3) -1))))

(defun test* ()
  (let ((*test-name* 'test*))
    (check
     (= (* 2 3) 6)
     (= (* 3 5) 15))))

(defun test-arithmatic ()
  (combine-results
   (test-+)
   (test*)))

(nl)
(format t "(test-arithmatic) = ~%")
(test-arithmatic)

;;;
;;; Abstruction Emerges
;;;  STOPPING HERE for chap09 FOR NOW 2019/12/28
;;;


;;
;; PS
;;
(setf ll (loop for i below 5 collect i))

(defmacro echo (f)
  `(format t "~a: ~a" ,f ',f))

(defmacro isprime (n)
  `(format t "~:[PRIME~;Non-PRIME~] ~a" (not (primep ,n)) ,n))

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))

;;
;; experiments, ideas
;;
(defmacro f1 ()
  `(progn (defun foo()
	    (format t "I am foo from f1"))
	  (foo)))

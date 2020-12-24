;;
;; Chapter 04: Functions
;;

;;
;; Function Parameters
;;  required parameters
;;  &optional: optional parameters
;;  &rest: rest parameters
;;  &key: keyword parameters
;;

;;
;; Functions As Data
;;
(defun foo4-1 ()
  (format t "Function foo4-1"))

(function foo4-1)
(funcall #'foo4-1)   ;; indirect invocation
(apply #'foo4-1 ())

(defun plot (fn min max step)
  (loop for i from min to max by step do
	(loop repeat (funcall fn i) do (format t "*"))
	(format t "~%")))

(plot #'exp 0 4 1/2)

(append '(I have a book.) '(You have a pen.))
(apply #'append '((I have a book.) (You have a Pen.)))

(plot #'(lambda (x) (* 2 x)) 0 10 1)

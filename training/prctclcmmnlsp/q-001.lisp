;;;
;;; 2020/01/22 Question 001
;;;   clisp: Loading this file just works. Even, (f0-foo)
;;;   sbcl:  load this file twice, and then it works. What's going on?
;;;

;;;
;;; % sbcl
;;; * (load "./q-001.lisp")
;;; * ;; warning: m1-macro() undefined for f0-foo and f1-foo
;;; * (f0-foo)
;;; * ;; Undefined Error
;;; * (load "./q-001.lisp")
;;; * T
;;; * (f0-foo)
;;; * ;; Works fine.
;;;
;;; % clisp
;;; > (load "./q-001.lisp")
;;; > (f0-foo)
;;; > ;; Works fine
;;;

(defun f0-foo()
  (format t "I am f0-foo() ~%")
  (m1-macro))

(defun f1-foo()
  (format t "I am f1-foo() ~%")
  (eval-when (:compile-toplevel
	      :load-toplevel
	      :execute)
	     (format t "In f1-foo~%")
	     (m1-macro)))

(defmacro m1-macro()
  '(format t "I am m1-macro()~%"))

(defun f2-foo()
  (format t "I am f2-foo ~%")
  (f3-foo))

(defun f3-foo()
  (format t "I am f3-foo~%")
  (m1-macro))

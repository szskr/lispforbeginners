;;;
;;;
;;;

(defun f10-foo()
  (format t "I am f10-foo() ~%")
  (m10-macro))

(defun f11-foo()
  (format t "I am f11-foo() ~%")
  (eval-when (:compile-toplevel
	      :load-toplevel
	      :execute)
	     (format t "In f11-foo~%")
	     (m10-macro)))

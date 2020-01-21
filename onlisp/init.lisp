;;;
;;; Little tools
;;;
(defun l ()
  (let ((files '("../libs/tools.lisp"
		 "./ch02.lisp")))
    (mapcar #'load files)))

(defun tools()
  (load "../libs/tools.lisp"))

(defun ch02()
  (load "./ch02.lisp"))

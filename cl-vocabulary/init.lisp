;;;
;;; Little tools
;;;
(defun l ()
  (let ((files '("../libs/tools.lisp"
		 "./word.lisp")))
    (mapcar #'load files)))

(defun init()
  (load "./init.lisp"))

(defun tools()
  (load "../libs/tools.lisp"))

(defun l-word()
  (load "./word.lisp"))





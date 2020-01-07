;;;
;;; Little tools
;;;
(defun l ()
  (let ((files '("../libs/tools.lisp"
		 "./a-word.lisp")))
    (mapcar #'load files)))

(defun i()
  (load "./init.lisp"))

(defun tools()
  (load "../libs/tools.lisp"))

(defun a-word()
  (load "./a-word.lisp"))

;;;
;;; Little tools
;;;

(defun l ()
  (let ((files '("../lib/tools.lisp"
		 "./stubs.lisp"
		 "./LispAndScheme.lisp")))
    (mapcar #'load files)))
  
(defun LispAndScheme ()
  (load "./LispAndScheme.lisp"))

(defun tools ()
  (load "../lib/tools.lisp"))

(defmacro comment-out (form)
  ())

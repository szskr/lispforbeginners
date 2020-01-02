;;;
;;; Little tools
;;;

(defun l ()
  (let ((files '("../lib/tools.lisp"
		 "./LispAndScheme.lisp")))
    (mapcar #'load files)))
  
(defun LispAndScheme ()
  (load "./LispAndScheme.lisp"))

(defun tools ()
  (load "../lib/tools.lisp"))

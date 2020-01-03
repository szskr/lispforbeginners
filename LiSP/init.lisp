;;;
;;; Little tools
;;;

(defun l ()
  (let ((files '("./tools.lisp"
		 "./stubs.lisp"
		 "./LispAndScheme.lisp"
		 "./ch01.lisp")))
    (mapcar #'load files)))
  
(defun LispAndScheme ()
  (load "./LispAndScheme.lisp"))

(defun tools ()
  (load "./tools.lisp"))

(defun ch01 ()
  (load "./ch01.lisp"))

(defmacro comment-out (form))

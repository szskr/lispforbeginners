;;;
;;; Little tools
;;;

(defparameter *pwd* "./LiSP")
(defmacro pwd()
  (format t "~a~%" *pwd*))

(defmacro comment-out (form))

(defun l ()
  (let ((files '("../libs/tools.lisp"
		 "./stubs.lisp"
		 "./LispAndScheme.lisp"
		 "./ch01.lisp")))
    (mapcar #'load files)))
  
(defun LispAndScheme ()
  (load "./LispAndScheme.lisp"))

(defun tools ()
  (load "../libs/tools.lisp"))

(defun ch01 ()
  (load "./ch01.lisp"))



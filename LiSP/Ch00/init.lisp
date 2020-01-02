;;;
;;; Little tools
;;;

(defun l ()
  (let ((files '("./LispAndScheme.lisp")))
    (mapcar #'load files)))
  
(defun LispAndScheme ()
  (load "./LispAndScheme.lisp"))

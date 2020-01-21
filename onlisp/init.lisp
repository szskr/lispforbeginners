;;;
;;; Little tools
;;;
(defun l ()
  (let ((files '("../libs/tools.lisp")))
    (mapcar #'load files)))

(defun tools()
  (load "../libs/tools.lisp"))

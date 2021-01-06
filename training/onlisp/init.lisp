;;;
;;; Little tools
;;;
(defun l ()
  (let ((files '("../libs/tools.lisp"
		 "./lisp.lisp"
		 "./maps.lisp"
		 "./ch02.lisp"
		 "./ch03.lisp"
		 "./ch04.lisp")))
    (mapcar #'load files)))

(defun tools()
  (load "../libs/tools.lisp"))

(defun lisp()
  (load "./lisp.lisp"))

(defun maps()
  (load "./maps.lisp"))

(defun ch02()
  (load "./ch02.lisp"))

(defun ch03()
  (load "./ch03.lisp"))

(defun ch04()
  (load "./ch04.lisp"))

;;;
;;; Little tools
;;;

(defun l ()
  (let ((files '("../libs/tools.lisp"
	       	 "./ch04.lisp"
		 "./ch08.lisp"
		 "./ch10.lisp"
		 )))
    (mapcar #'load files)))


(defun ch10 ()
  (load "./ch10.lisp"))

(defun ch08 ()
  (load "./ch08.lisp"))

(defun ch04 ()
  (load "./ch04.lisp"))
  
(defun tools ()
  (load "./tools.lisp"))


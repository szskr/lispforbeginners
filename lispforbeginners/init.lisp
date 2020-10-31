
;;;
;;; Little tools
;;;

(defun l ()
  (let ((files '("../libs/tools.lisp"
		 "./init.lisp"
	       	 "./ch04.lisp"
		 "./ch08.lisp"
		 "./ch10.lisp"
		 "./ch11.lisp"
		 "./ch12.lisp"
		 "./ch13.lisp"
		 "./tiny-lisp.lisp"
		 )))
    (mapcar #'load files)))

(defun ch13 ()
  (load "./ch13.lisp"))

(defun ch12 ()
  (load "./ch12.lisp"))
  
(defun ch11 ()
  (load "./ch11.lisp"))

(defun ch10 ()
  (load "./ch10.lisp"))

(defun ch08 ()
  (load "./ch08.lisp"))

(defun ch04 ()
  (load "./ch04.lisp"))

(defun tiny-lisp ()
  (load "./tiny-lisp.lisp"))
  
(defun tools ()
  (load "./tools.lisp"))


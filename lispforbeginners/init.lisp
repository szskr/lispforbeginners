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
		 "./tiny-lisp.lisp"
		 "./ch14.lisp"
		 "./notes.lisp"
		 "./tmp.lisp"
		 )))
    (mapcar #'load files)))

(defun ch14 ()
  (load "./ch14.lisp"))

(defun tiny-lisp ()
  (load "./tiny-lisp.lisp"))

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

(defun notes()
  (load "./notes.lisp"))

(defun tmp()
  (load "./tmp.lisp"))

(defun tools ()
  (load "./tools.lisp"))


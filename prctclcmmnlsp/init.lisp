;;;
;;; Little tools
;;;
(defun l ()
  (let ((files '("./ch03.lisp" "./ch04.lisp"
	       "./ch05.lisp" "./ch07.lisp"
	       "./ch08.lisp" "./ch09.lisp"
	       "./ch21.lisp")))
    (mapcar #'load files)))

(defun ch21 ()
  (load "./ch21.lisp"))

(defun ch09 ()
  (load "./ch09.lisp"))

(defun ch08 ()
  (load "./ch08.lisp"))

(defun ch07 ()
  (load "./ch07.lisp"))

(defun ch05 ()
  (load "./ch05.lisp"))

(defun ch04 ()
  (load "./ch04.lisp"))
  
(defun ch03 ()
  (load "./ch03.lisp"))
 

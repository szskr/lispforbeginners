;;;
;;; Little tools
;;;
(defun l ()
  (let ((files '("./tools.lisp"
		 "./ch03.lisp"
		 "./ch04.lisp"
		 "./ch05.lisp"
		 "./ch06.lisp"
		 "./ch07.lisp"
		 "./ch08.lisp"
		 "./ch09.lisp"
		 "./ch11.lisp"
		 "./ch13.lisp"
		 "./ch14.lisp" 
		 "./ch15.lisp"
		 "./ch16.lisp"
		 "./ch17.lisp"
		 "./ch19.lisp"
		 "./ch20.lisp"
		 "./ch21.lisp"
		 "./ch23.lisp"
		 "./ch24.lisp"
		 "./x-methods.lisp"
		 "./y-ch24.lisp"
		 "./z-appndx-ch24.lisp")))
    (mapcar #'load files)))

(defun y-ch24 ()
  (load "./y-ch24.lisp"))

(defun x-methods ()
  (load "./x-methods.lisp"))

(defun ch24 ()
  (load "./ch24.lisp"))

(defun anndx-ch24 ()
  (load "./z-appndx-ch24.lisp"))

(defun ch23 ()
  (load "./ch23.lisp"))

(defun ch21 ()
  (load "./ch21.lisp"))

(defun ch20 ()
  (load "./ch20.lisp"))

(defun ch19 ()
  (load "./ch19.lisp"))

(defun ch17 ()
  (load "./ch17.lisp"))

(defun ch16 ()
  (load "./ch16.lisp"))

(defun ch15 ()
  (load "./ch15.lisp"))

(defun ch14 ()
  (load "./ch14.lisp"))

(defun ch13 ()
  (load "./ch13.lisp"))

(defun ch11 ()
  (load "./ch11.lisp"))

(defun ch09 ()
  (load "./ch09.lisp"))

(defun ch08 ()
  (load "./ch08.lisp"))

(defun ch07 ()
  (load "./ch07.lisp"))

(defun ch06 ()
  (load "./ch06.lisp"))

(defun ch05 ()
  (load "./ch05.lisp"))

(defun ch04 ()
  (load "./ch04.lisp"))
  
(defun ch03 ()
  (load "./ch03.lisp"))

(defun tools ()
  (load "./tools.lisp"))

;;;
;;; Load flag
;;;
(setf *l-ppcre-loaded* nil)

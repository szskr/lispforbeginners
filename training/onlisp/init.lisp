;;;
;;; Little tools
;;;
(setq figures '("./fig0401.lisp"
		"./fig0402.lisp"))

(defun l ()
  (let ((files '("../libs/tools.lisp"
		 "./00-lisp.lisp"
		 "./01-maps.lisp"
		 "./02-loops.lisp"
		 "./ch02.lisp"
		 "./ch03.lisp"
		 "./ch04.lisp")))
    (mapcar #'load files))
  (mapcar #'load figures))

(defun fig()
  (mapcar #'load figures))

(defun tools()
  (load "../libs/tools.lisp"))

(defun init()
  (load "./init.lisp"))

(defun lisp()
  (load "./00-lisp.lisp"))

(defun maps()
  (load "./01-maps.lisp"))

(defun loops()
  (load "./02-loops.lisp"))

(defun ch02()
  (load "./ch02.lisp"))

(defun ch03()
  (load "./ch03.lisp"))

(defun ch04()
  (load "./ch04.lisp"))

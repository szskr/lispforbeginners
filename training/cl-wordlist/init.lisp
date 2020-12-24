;;;
;;; Little tools
;;;
(defun l ()
  (let ((files '("../libs/tools.lisp"
		 "./wordlist.lisp")))
    (mapcar #'load files)))

(defun i()
  (load "./init.lisp"))

(defun tools()
  (load "../libs/tools.lisp"))

(defun wordlist()
  (load "./wordlist.lisp"))

(defun run-tests ()
  (let ((tests '("./test01.lisp")))
    (mapcar #'load tests)))

(defun test01 ()
  (load "./test01.lisp"))

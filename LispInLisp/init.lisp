;;
;;
;;
(defun init ()
  (let ((files '("tiny-lisp.lisp"
		 "micro-lisp.lisp")))
    (mapcar #'load files)))

(defun micro-lisp ()
  (load "./micro-lisp"))

;;;
;;;
;;;
(defun l-regex ()
  (let ((files '("./packages.lisp"
		 "./specials.lisp"
		 "./util.lisp"
		 "./parser.lisp"
		 "./lexer.lisp"
		 "./scanner.lisp"
		 "./convert.lisp"
		 "./chartest.lisp"
		 "./errors.lisp"
		 "./charmap.lisp"
		 "./regex-class.lisp"
		 "./regex-class-util.lisp"
		 "./closures.lisp"
		 "./repetition-closures.lisp"
		 "./optimize.lisp"
		 "./api.lisp")))
    (mapcar #'load files)))
)

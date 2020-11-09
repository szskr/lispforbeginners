;;
;; supplementary
;;

(setq foo-def '(defun foo()
		 (print "hello")))

(setq hoo-mac '(defmacro hoo()
		 `(print "hoo")))

(defun foo()
  (print "hello"))

(defmacro hoo()
  `(print "hoo"))

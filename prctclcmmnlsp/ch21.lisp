;;
;; Chapter 21: Programming in the Large: Package and Symbols
;;

(nl)
(nl)
(chap21)
(comment "Chapter 21")
(nl)

;;;
;;;How the Reader Uses Packages
;;;

*package*     ;; The current package
(format t "The current package is ~a " *package*)
(nl)

(format t "~a~%" (symbol-name :foo))
(format t "~a~%" (symbol-name 'foo-bar))
(format t "~a~%" (gensym))

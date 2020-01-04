;;;
;;; Notes for translating Scheme codes into Common Lisp codes
;;;

;;;
;;; Scheme: atom?   == CommonLisp: atom
;;; Scheme: symbol? == CommonLisp: symbol
;;; Scheme: pair?   == CommonLisp: listp
;;; Scheme: define  == CommonLisp: defun
;;;

(nl)
(comment "LispAndScheme")

(format t "(scheme:atom? is cl:atom~%")
(nl)
(format t "(atom 1) = ~a~%" (atom 1))
(format t "(atom :keyword) = ~a~%" (symbolp :keyword))

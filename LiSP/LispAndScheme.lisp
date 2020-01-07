;;
;; Notes for translating Scheme codes into Common Lisp codes
;;

;;
;; Chapter 01: The Basics of Interpretation
;;

;;;
;;; Scheme: atom?    == CommonLisp: atom
;;; Scheme: symbol?  == CommonLisp: symbol
;;; Scheme: number?  == CommonLisp:
;;; Scheme: string?  ==
;;; Scheme: char?    ==
;;; Scheme: boolean? ==
;;; Scheme: vector?  ==
;;; Scheme: pair?    == CommonLisp: consp       ;; SEE: Issue (1)
;;; Scheme: define   == CommonLisp: defun
;;; Scheme: eq?      == CommonLisp:
;;;

(nl)
(comment "LispAndScheme")

(format t "(scheme:atom? is cl:atom~%")
(nl)
(format t "(atom 1) = ~a~%" (atom 1))
(format t "(atom :keyword) = ~a~%" (symbolp :keyword))

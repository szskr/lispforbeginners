;;
;; Notes for translating Scheme codes into Common Lisp codes
;;

;;
;; Chapter 01: The Basics of Interpretation
;;

;;; Scheme      CommonLisp
;;; -----------------------
;;; atom?    == atom
;;; symbol?  == symbolp
;;; number?  == numberp
;;; string?  == stringp
;;; char?    ==
;;; boolean? == null        // ???? 
;;; vector?  == vectorp
;;; pair?    == consp       // SEE: Issue (1)
;;; define   == defun
;;; eq?      == equal       // (or could be 'eq' ??)
;;;

(nl)
(comment "LispAndScheme")

(format t "(scheme:atom? is cl:atom~%")
(nl)
(format t "(atom 1) = ~a~%" (atom 1))
(format t "(atom :keyword) = ~a~%" (symbolp :keyword))

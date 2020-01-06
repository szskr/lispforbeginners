;;;
;;; Notes for translating Scheme codes into Common Lisp codes
;;;

;;;
;;; Scheme: atom?   == CommonLisp: atom
;;; Scheme: symbol? == CommonLisp: symbol
;;; Scheme: pair?   == CommonLisp: consp       ;; SEE: FootNotes (1), also Issue (1)
;;; Scheme: define  == CommonLisp: defun
;;;

(nl)
(comment "LispAndScheme")

(format t "(scheme:atom? is cl:atom~%")
(nl)
(format t "(atom 1) = ~a~%" (atom 1))
(format t "(atom :keyword) = ~a~%" (symbolp :keyword))


;;;
;;; FootNotes
;;;

;;; (1) Scheme pair? and CommonLisp consp
;;;;
;;;; notifications@github.com (2020/01/06, from KJ)
;;;; This message is from a mailing list.
;;;; 
;;;; Greetings. I think your comparison of 'pair?' to 'list' is probably mistaken, although it can almost be
;;;; treated the same way because of visual representation. Not all lists are pairs, until you view them as consed.
;;;;
;;;; Instead, pair? is closer to CL's consp. A cons is literally a pair, and consp is the associated predicate.
;;;; A plist is a list of pairs. And a list can contain any number of elements (ie: not limited to exactly 2).
;;;; As you dig deeper, you'll find that every list is a list of conses,
;;;l but don't have to be represented that way - hence the confusion.
;;;; 
;;;; Here's a link to the hyperspec for consp:
;;;;     http://www.lispworks.com/documentation/HyperSpec/Body/f_consp.htm#consp
;;;;
;;;; Enjoy!
;;;
;;;  THANKS!
;;;


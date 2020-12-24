;;
;; Chapter 12: They Called it LISP for a Reason: List Processing
;;

(nl)
(chap12)
(comment "Chapter 12")
(nl)

;;;
;;; Examples
;;;

(comment "Examples: Destructive Operation")
(format t "(defparameter *l1* (list 1 2)) = ~a~%" (defparameter *l1* (list 1 2)))
(format t "(defparameter *l2* (list 3 4)) = ~a~%" (defparameter *l2* (list 3 4)))
(format t "(defparameter *l3* (append *l1* *l2*)) = ~a~%" (defparameter *l3* (append *l1* *l2*)))
(format t "*l1* = ~a~%" *l1*)
(format t "*l2* = ~a~%" *l2*)
(format t "*l3* = ~a~%" *l3*)
(nl)

(format t "(setf (first *l2*) 0) = ~a~%" (setf (first *l2*) 0))
(format t "*l1* = ~a~%" *l1*)
(format t "*l2* = ~a~%" *l2*)
(format t "*l3* = ~a~%" *l3*)
(nl)

(format t "(nconc *l1* '(A B C)) = ~a~%" (nconc *l1* '(A B C)))
(format t "*l1* = ~a~%" *l1*)
(format t "*l2* = ~a~%" *l2*)
(format t "*l3* = ~a~%" *l3*)

;;;
;;; Mapping
;;;
(comment "Mapping")
(nl)

(comment "MAPCAR")
(format t "(mapcar #'(lambda (x) (* 2 x)) (list 1 2 3)) = ~a~%" (mapcar #'(lambda (x) (* 2 x)) (list 1 2 3)))
(format t "(mapcar #'+ (list 1 2 3) (list 10 20 30))    = ~a~%" (mapcar #'+ (list 1 2 3) (list 10 20 30)))
(nl)

;;;
;;; MAPLIST/MAPCAN/MAPCON
;;;
(comment "MAPLIST/MAPCAN/MAPCON: Check on them when you have a chance.")

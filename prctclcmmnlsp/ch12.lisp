;;
;; Chapter 12: They Called it LISP for a Reason: List Processing
;;

(nl)
(chap12)
(comment "Chapter 12")

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

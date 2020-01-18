;;;
;;; Chapter 11: Collections
;;;

(nl)
(chap11)
(comment "Chapter 11")
(nl)

;;;
;;; Sequence Mapping Functions
;;;
(comment "Sequence Mapping Functions")
(nl)

(comment "MAP - three examples")

(format t "(map 'vector #'+ '(10 20 30) '(100 200 300))     = ~a~%"
	(map 'vector #'+ '(10 20 30) '(100 200 300)))

(format t "(map 'list   #'+ '(10 20 30) '(100 200 300))     =  ~a~%"
	(map 'list #'+ '(10 20 30) '(100 200 300)))

(format t "(map 'list   #'(lambda (x) (* x x)) '(10 20 30)) =  ~a~%"
	(map 'list #'(lambda (x) (* x x)) '(10 20 30)))
(nl)

(comment "MAP-INTO")
(defvar a '(1 2 3))
(setf a '(1 2 3))
(defvar b '(10 20 30))
(defvar c '(100 200 300))

(format t "a = ~a~%" a)
(format t "b = ~a~%" b)
(format t "c = ~a~%" c)
(format t "(map-into a #'+ a b c) = ~a~%" (map-into a #'+ a b c))
(format t "a = ~a~%" a)


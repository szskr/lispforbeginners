;;;
;;; Mapping Functions 
;;;

(comment "Mapping Functions")
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

(nl)
(comment "REDUCE: A surprising useful function")
(format t "(reduce #'+ '(1 2 3 4 5) = ~a~%" (reduce #'+ '(1 2 3 4 5)))
(format t "(reduce #'max '(10 1 11 3 100 4) = ~a~%" (reduce #'max '(10 1 11 3 100 4)))

(comment "MAPCAR")
(format t "(mapcar #'(lambda (x) (* 2 x)) (list 1 2 3)) = ~a~%" (mapcar #'(lambda (x) (* 2 x)) (list 1 2 3)))
(format t "(mapcar #'+ (list 1 2 3) (list 10 20 30))    = ~a~%" (mapcar #'+ (list 1 2 3) (list 10 20 30)))
(nl)

(comment "MAPCAN")

(format t "(mapcan #'+ '(10)) = ~a~%" (mapcan #'+ '(10)))
(format t "(mapcan #'+ '(10) '(100)) = ~a~%" (mapcan #'+ '(10) '(100)))
(format t "(mapcan #'+ '(10) '(100) '(1000)) = ~a~%" (mapcan #'+ '(10) '(100) '(1000)))

(defun remove-10 (l)
  (mapcan #'(lambda (x) (if (= x 10) nil
			  (list x))) l))

(format t "(remove-10 '(1 20 10 7 10 )) = ~a~%" (remove-10 '(1 20 10 7 10)))

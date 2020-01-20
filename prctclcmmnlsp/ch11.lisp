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

(nl)
(comment "REDUCE: A surprising useful function")
(format t "(reduce #'+ '(1 2 3 4 5) = ~a~%" (reduce #'+ '(1 2 3 4 5)))
(format t "(reduce #'max '(10 1 11 3 100 4) = ~a~%" (reduce #'max '(10 1 11 3 100 4)))

;;;
;;; Hash Tables
;;;
(comment "Hash Tables")
(nl)
(format t "(defparameter *h* (make-hash-table)) = ~a~%" (defparameter *h* (make-hash-table)))
(format t "(gethash 'foo *h*) = ~a~%" (gethash 'foo *h*))
(format t "(setf (gethash 'foo *h*) 'quux) = ~a~%" (setf (gethash 'foo *h*) 'quux))
(format t "(gethash 'foo *h*) = ~a~%" (gethash 'foo *h*))

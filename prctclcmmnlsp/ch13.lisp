;;
;; Chapter 13: Beyond List: Other Uses for Cons Cells
;;

(nl)
(chap13)
(comment "Chapter 13")
(nl)

;;;
;;; Sets
;;;
(comment "Sets")
(nl)
(format t "(defparameter t *set* ()) = ~a~%" (defparameter *set* ()))
(format t "(setf *set* (adjoin 1 *set*)) = ~a~%" (setf *set* (adjoin 1 *set*)))
(format t "*set* = ~a~%" *set*)
(nl)

;;;
;;; Lookup Tables: Alist and Plists
;;;

;;;
;;; Association List
;;; 
(comment "ALIST and assoc funtion")
(defparameter *l* ())
(format t "(setq *l* (list (cons 'a 1) (cons 'b 2) (cons 'c 3))) = ~a~%"
	(setq *l* (list (cons 'a 1) (cons 'b 2) (cons 'c 3))))

(format t "*l* = ~a~%" *l*)
(format t "(assoc 'a *l*) = ~a~%" (assoc 'a *l*))
(format t "(assoc 'c *l*) = ~a~%" (assoc 'c *l*))
(format t "(assoc 'd *l*) = ~a~%" (assoc 'd *l*))
(nl)
(comment "Adding data into a ALIST")
(format t "(setf *l* (acons 'd 1000 *l*) = ~a~%" (setf *l* (acons 'd 1000 *l*)))
(format t "(assoc 'd *l*) = ~a~%" (assoc 'd *l*))
(nl)

(format t "(assoc 1 '((100 1) (2 3) (1 100))) = ~a~%" (assoc 1 '((100 1) (2 3) (1 100))))
(format t "(assoc 1 '((100 1) (1 2 3) (1 100))) = ~a~%" (assoc 1 '((100 1) (1 2 3) (1 100))))
(nl)

(format t "(assoc '(1 2) '((100 1) (1 2 3) ((1 2) 100))) = ~a~%" (assoc '(1 2) '((100 1) (1 2 3) ((1 2) 100))))
(nl)

;;;
;;; PAIRLIS function
;;;
(comment "PLISR and PAIRLIS function")
(format t "(pairlis '(a b c) '(1 2 3)) = ~a~%" (pairlis '(a b c) '(1 2 3)))
(format t "(defparameter  *pairlist* (pairlis '(a b c) '(1 2 3))) = ~a~%"
	(defparameter *pairlist* (pairlis '(a b c) '(1 2 3))))
(format t "*pairlist* = ~a~%" *pairlist*)
(nl)

;;;
;;; Property List: PLIST
;;;
(comment "Property List: plist")
(format t "(defparameter *plist* ()) = ~a~%" (defparameter *plist* ()))
(format t "(setf (getf *plist* :a) 1) = ~a~%" (setf (getf *plist* :a) 1))
(format t "*plist* = ~a~%" *plist*)
(format t "(setf (getf *plist* :a) 2) = ~a~%" (setf (getf *plist* :a) 2))
(format t "*plist* = ~a~%" *plist*)
(format t "(setf (getf *plist* :xx) 100) = ~a~%" (setf (getf *plist* :xx) 100))
(format t "*plist* = ~a~%" *plist*)
(nl)
(format t "(remf *plist* :a) = ~a~%" (remf *plist* :a))
(format t "*plist* = ~a~%" *plist*)
(nl)

;;;
;;; Symbol-plist
;;;
(comment "SYMBOL-PLIST")
(format t "(symbol-plist '*plist*) = ~a~%" (symbol-plist '*plist*))
(format t "(getf (symbol-plist '*plist*) :x) = ~a~%" (getf (symbol-plist '*plist*) :x))
(format t "(get '*plist* :x) = (getf (symbol-plist '*plist*) :x) = ~a~%" (get '*plist* :x))
(format t "(setf (get '*plist* :x) 100) = ~a~%" (setf (get '*plist* :x) 100))
(format t "(get '*plist* :x) = ~a~%" (get '*plist* :x))
(nl)

(format t "(symbol-plist '*plist*) = ~a~%" (symbol-plist '*plist*))
(format t "(remprop 'symbol 'key) == (refm (symbol-plist 'symbol key))~%")
(format t "(remprop '*plist* ':x) = ~a~%" (remprop '*plist* 'X))
(format t "(symbol-plist '*plist*) = ~a~%" (symbol-plist '*plist*))

;;
;; Chapter 03: Functional Programming
;;
(comment "Chap03: Functional Programming")
(nl)

(comment "03.01 Functional Programming Design")

(myformat "(truncate 17.123) = ~a~%" (truncate 17.123))

;;
;; Diag 3.2
;;
(defun good-reverse (lst)
  (labels ((rev (tlst acc)
		(if (null tlst)
		    acc
		  (rev (cdr tlst) (cons (car tlst) acc)))))
	  (rev lst nil)))

;;
;;
(defun ok (x)
  (nconc (list 'a x) (list 'c)))

(defun not-ok (x)
  (nconc (list 'a) x (list 'c)))   ;; THis is not ok because it modifies the argument passed.

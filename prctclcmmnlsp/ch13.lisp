;;
;; Chapter 13: Beyond List: Other Uses for Cons Cells
;;

(nl)
(chap13)
(comment "Chapter 13")
(nl)

;;;
;;; Lookup Tables: Alist and Plists
;;;
(comment "ALIST and assoc funtion")
(defvar *l* ())
(format t "(setq *l* (list (cons 'a 1) (cons 'b 2) (cons 'c 3)))~%")
(format t "*l* = ~a~%" *l*)
(format t "(assoc 'a *l*) = ~a~%" (assoc 'a *L*))
(format t "(assoc 'c *l*) = ~a~%" (assoc 'c *l*))
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
(defvar *p1* (pairlis '(a b c) '(1 2 3)))
;;;
;;; 

;;;
;;; funcall, apply and maps 
;;;

(setq a1 (+ 1 2 3))
(setq a2 (funcall #'+ 1 2 3))
(setq a3 (apply #'+ '(1 2 3)))

(setq c1 (cons 'a 'b))
(setq c2 (funcall #'cons 'a 'b))
(setq c3 (apply #'cons '(a b)))

(setq l1 (list 1 2 3 '(a b)))
(setq l2 (funcall #'list 1 2 3 '(a b)))
(setq l3 (apply #'list '(1 2 3 (a b))))


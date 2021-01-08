;;
;; values and multiple-value-bind
;;
(defun square-cube (x)
  (values (* x x) (* x x x)))

(multiple-value-bind (s c)
		     (square-cube 2)
		     (list s c))

(defun s-c-list (x)
  (multiple-value-bind (s c)
		       (square-cube x)
		       (list s c)))

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

;;
;; maps - mapcar, maplist, mapc, 
;;
(setq nums '(1 2 3 4 5 6 7 8 9 10))

;;
;; mapcar
;;
(setq m0 (mapcar #'+ nums))
(setq m1 (mapcar #'+ nums nums))
(setq m2 (mapcar #'(lambda (x) (* x x)) nums))

;;
;; A simple version of mapcar
;;
(defun my-mapcar (fn mlist)
  (cond ((null mlist) nil)
	(t (cons (funcall fn (car mlist))
		 (my-mapcar fn (cdr mlist))))))

(setq mm0 (my-mapcar #'+ nums))
;(setq mm1 (my-mapcar #'+ nums nums))
(setq mm2 (my-mapcar #'(lambda (x) (* x x)) nums))

;; 
;; maplist
;;
(setq ml0 (maplist (lambda (l) (cons 0 l)) '(1 2 3 4)))

(setq ml1 (maplist #'append
		   '(a b c d - )
		   '(1 2 3 4)))

(setq ml2 (maplist (lambda (l) (+ 100 (car l))) nums))

;;
;; A simple version of maplist
;;
(defun my-maplist (fn mlist)
  (cond ((null mlist) nil)
	(t (cons (funcall fn mlist)
		 (my-maplist fn (cdr mlist)) ))))

(setq mml0 (my-maplist (lambda (l) (cons 0 l)) '(1 2 3 4)))

;;(setq mml1 (my-maplist #'append
;;		   '(a b c d - )
;;		   '(1 2 3 4)))

(setq ml2 (maplist (lambda (l) (+ 100 (car l))) nums))

;;
;; mapc
;;
(setq mc0 (mapc #'+ nums))
(setq mc1 (mapc #'+ nums nums))
(write "Going to mapc square")
(setq mc2 (mapc #'(lambda (x) (print (* x x)) (* x x)) nums))

;;
;; A simple version of mapcar
;;
(defun my-mapc (fn mlist)
  (do ((x mlist (cdr x)))
      ((null x) mlist)
      (funcall fn (car x))))

(setq mmc0 (my-mapc #'+ nums))
;(setq mmc1 (my-mapc #'+ nums nums))
(write "Going to my-mapc square")
(setq mc2 (my-mapc #'(lambda (x) (print (* x x)) (* x x)) nums))

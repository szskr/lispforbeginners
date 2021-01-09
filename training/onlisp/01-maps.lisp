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

;;
;; On mapcan
;;
(setf mc0 '((a b) (c) (1 2 3)))

(defun numbers-of (l)
  (mapcan (lambda (e)
	    (if (numberp e)
		(list e)
	      '()))
	  l))

;;
;; various
;;
(setq a '(a b c d e))

(defun m-mapcar (x)
  (mapcar (lambda (y) (list y y)) x))
(setf a1 (m-mapcar a))

(defun m-nconc (x)
  (apply #'nconc (m-mapcar x)))
(setf a2 (m-nconc a))

(defun m-mapcan (x)
  (mapcan (lambda (y) (list y y)) x))
(setf a3 (m-mapcan a))

(defun m-maplist (x)
  (maplist (lambda (y) (copy-list y)) x))
(setf a4 (m-maplist a))

(defun m-nconc2 (x)
  (apply #'nconc (maplist (lambda (y) (copy-list y)) x)))
(setf a5 (m-nconc2 a))

(defun m-mapcon (x)
  (mapcon (lambda (y) (copy-list y)) x))
(setf a6 (m-mapcon a))

;;
;; misc examples
;;
(setq nums '(1 2 3 4 5 6 7 8 9 10))
(defun m2-mapcar (n)
  (mapcar (lambda (x) (evenp x)) n))

(defun m2-mapcan (n)
  (mapcan (lambda (x) (if (evenp x) (list x))) n))


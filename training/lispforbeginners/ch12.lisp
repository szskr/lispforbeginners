;;
;; Chapter 12
;;
(setq x '(1 2))
(setq l '(1 2 3 4 5))

(apply 'cons x)
(apply '+ l)

(setq tissue "tissue")
(setq candy "candy")
(setq cookie "cookie")
(setq zanmai "zanmai")
(setq chicken "chicken")

(setq prices-0 '(98 125 268 95 95 244))

(setq prices-1 (list (cons 'tissue 98) (cons 'candy 125) (cons 'coolie 268)
		     (cons 'zanmai 95) (cons 'zanmai 95) (cons 'chicken 244)))

(setq prices-2 (list (list 'tissue 98) (list 'candy 125) (list 'coolie 268)
		     (list 'zanmai 95) (list 'zanmai 95) (list 'chicken 244)))

;;
;; p.190
;;
(defun get-total-a (prices)
  (prog (total x)
	(setq x prices)
	(setq total 0)
	loop (cond ((null x) (return total)))
	(setq total (+ (pop x) total))
	(go loop)))

(defun get-total-c (prices)
  (let ((total 0))
    (do ((x prices (cdr x)))
	((null x) total)
	(setq total (+ (car x) total)) )))

;;
;; p.191
;;
(defmacro get-total-b (prices)
  `(apply '+ ,prices))

;;
;; p.192
;;
(defmacro get-total-1 (get-price list)
   ` (let ((total 0))
    (do ((x ,list (cdr x)))
	((null x) total)
	(setq total (+ (,get-price (car x)) total))
	)))

;;
;; p.193
;;
(defun rec-total (prices)
  (cond ((null prices) 0)
	(t (+ (car prices) (rec-total (cdr prices))))))

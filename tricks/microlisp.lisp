;;;
;;; Experimental Micro Lisp
;;;

(defun lm ()
  (load "./microlisp.lisp"))

;;
;; micro-eval
;;
(defun micro-eval (s environment)
  (cond ((atom s)
	 (cond ((equal s t) t)
	       ((equal s nil) nil)
	       ((numberp s) s)
	       (t (micro-value s environment))))
	((equal (car s) 'm-quote) (cadr s))
	((equal (car s) 'm-cond)
	 (micro-evalcond (cdr s) environment))
	(t (micro-apply (car s)
			(mapcar '(lambda (x)
				   (micro-eval x environment))
				(cdr s))
			environment))))

;;
;; micro-apply
;;    ;; commenting out m-times
;;
(defun micro-apply (function args environment)
  (cond ((atom function)
	 (cond ((equal function 'm-car) (caar args))
	       ((equal function 'm-cdr) (cdar args))
	       ((equal function 'm-cons) (cons (car args)
					       (cadr args)))
	       ((equal function 'm-atom) (atom(car args)))
	       ((equal function 'm-null) (null (car args)))
	       ((equal function 'm-equal) (equal (car args)
						 (cadr args)))
	      ;; ((equal function 'm-times) (times (car args)
						;; (cadr args)))
	       (t (micro-apply
		   (micro-eval function environment)
		   args
		   environment))))
	((equal (car function) 'm-definition)
	 (micro-eval (caddr function)
		     (micro-bind (cadr function) args environment)))))

;;;
;;; NEED WORK!
;;;
(defun micro-r-e-p ()
  (prog (s environment)
       loop
       (setq s (read))
       (cond ((atom s)
	      (print (micro-eval s environment)))
	     ((equal (car s) 'm-defun)
	      (setq environment
		    (cons (list (cadr s)
				(cons (list (cadr s)
					    (cons 'm-definition
						  (cddr s)))
					    environment))
			  (print (cadr s)))))
	     (t (print (micro-eval s environment))))
       (go loop)))

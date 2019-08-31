;;;
;;; Experimental Micro Lisp
;;;

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

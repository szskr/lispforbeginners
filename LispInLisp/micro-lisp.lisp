;;
;; Micro Lisp
;;   (micro-eval     s env)
;;   (micro-apply    func args env)
;;   (micro-evalcond clauses env)
;;   (micro-bind     key-list value-list a-list)
;;   (micro-value    key a-list)
;;
;;   (micro-rep)
;;
;; Basic functions
;;   m-quote        : micro-eval
;;   m-cond         : micro-eval
;;   m-car          : micro-apply
;;   m-cdr          : micro-apply
;;   m-cons         : micro-apply
;;   m-atom         : micro-apply
;;   m-null         : micro-apply
;;   m-equal        : micro-apply
;;   m-defun        : micro-rep
;;
;;   m-env          : micro-eval
;;   m-bye          : micro-rep

(defun micro-eval (s env)
  (progn (print "micro-eval     called")
  (cond ((atom s)
	 (cond ((equal s t) t)
	       ((equal s nil) nil)
	       ((numberp s) s)
	       (t (micro-value s env))))
	((equal (car s) 'm-quote) (cadr s))
	((equal (car s) 'm-env) (print env))
	((equal (car s) 'm-cond)
	 (micro-evalcond (cdr s) env))
	(t (micro-apply (car s)
			(mapcar #'(lambda (x)
				    (micro-eval x env))
				(cdr s))
			env)))))

(defun micro-apply (func args env)
  (progn (print "micro-apply    called")
  (cond ((atom func)
	 (cond ((equal func 'm-car) (caar args))
	       ((equal func 'm-cdr) (cdar args))
	       ((equal func 'm-cons) (cons (car args)
					       (cadr args)))
	       ((equal func 'm-atom) (atom (car args)))
	       ((equal func 'm-null) (null (car args)))
	       ((equal func 'm-equal) (equal (car args)
					     (cadr args)))
	       (t (micro-apply
		   (micro-eval func env)
		   args
		   env))))
	((equal (car func) 'm-definition)
	 (micro-eval (caddr func)
		     (micro-bind (cadr func) args env))))))

(defun micro-evalcond (clauses env)
  (progn (print "micro-evalcond called")
  (cond ((null clauses) nil)
	((micro-eval (caar clauses) env)
	 (micro-eval (cadar clauses) env))
	(t (micro-evalcond (cdr clauses) env)))))

(defun micro-bind (key-list value-list a-list)
  (progn (print "micro-bind     called")
  (cond ((or (null key-list) (null value-list)) a-list)
	(t (cons (list (car key-list) (car value-list))
		 (micro-bind (cdr key-list)
			     (cdr value-list)
			     a-list))))))

(defun micro-value (key a-list)
  (progn (print "micro-value    called")
  (cadr (assoc key a-list))))

(defun micro-rep ()
  (prog (s env)
	loop
	(format t ">> ")
	(force-output nil)
	(setq s (read))
	(cond ((atom s)
	       (print (micro-eval s env)))
	      ((equal (car s) 'm-env)
	       (print env))
	      ((equal (car s) 'm-defun)
	       (setq env (cons (list (cadr s)
				     (cons 'm-definition
					   (cddr s)))
			       env))
	       (print (cadr s)))
	      ((equal (car s) 'm-bye)
	       (return))
	      (t (print (micro-eval s env))))
	(go loop)))

;;
;; Expand
;;

;;
;; Based on 「LISP」(1981) by P.H. Winston & B.L.P Horn
;;           From  Chapter 23: Lisp in Lisp
;;

;;
;; Micro Lisp Interpreter 
;;   (micro-eval     s env)
;;   (micro-apply    func args env)
;;   (micro-rep)
;;
;;  Basic Micro functions
;;   m-quote        : micro-eval
;;   m-cond         : micro-eval
;;   m-setq         : micro-eval
;;
;;   m-car          : micro-apply
;;   m-cdr          : micro-apply
;;   m-cons         : micro-apply
;;   m-atom         : micro-apply
;;   m-null         : micro-apply
;;   m-equal        : micro-apply
;;   m-times        : micro-apply
;;   m-add          :: micro-apply
;;
;;   m-defun        : micro-rep
;;   m-lambda       : micro-eval
;;
;;  Helper micro- functions
;;   (micro-evalcond clauses env)
;;   (micro-bind     key-list value-list a-list)
;;   (micro-value    key a-list)
;;   (micro-setq     variable value a-list)
;;
;;  Misc Functions
;;   env            :: micro-rep
;;   bye            :: micro-rep
;;   debug-on       :: micro-rep
;;   debug-off      :: micro-rep
;;
;; Misc functions
;;   m_print        :: for debugging
;;

;;
;; MISC EXAMPLES
;;
;;   (micro-rep)
;;   >> (env)
;;   >> (debug-on)
;;   >> (m-setq a 2)
;;   >> a
;;   >> (debug-off)
;;   >> (env)
;;   >> 
;;   >> (m-defun m-twice (f x) (f (f x)))
;;   >> (m-twice (m-lambda (n) (m-times n n)) 2)
;;   >> 
;;   >> (m-defun m-append (l1 l2)
;;        (m-cond ((m-null l1) l2)
;;                (t (m-cons (m-car l1)
;;                           (m-append (m-cdr l1) l2)))))
;;   >> (bye)
;;

;;
;; WARNING
;;   Don't invoke undefined functions in the interpreter. Falls into an infinite loop.
;;

(defun micro-eval (s env)
  (progn (m_print "micro-eval     called")
  (cond ((atom s)
	 (cond ((equal s t) t)
	       ((equal s nil) nil)
	       ((numberp s) s)
	       ((stringp s) s)
	       (t (micro-value s env))))
	((equal (car s) 'm-quote) (cadr s))
     	((equal (car s) 'm-cond)
	 (micro-evalcond (cdr s) env))
	((equal (car s) 'm-setq)
	 (micro-setq (cadr s) (caddr s) env))
	((equal (car s) 'm-lambda)
	 (list 'm-closure (cadr s) (caddr s) env))
	(t (m_print "  Calling micro-apply")
	   (micro-apply (car s)
			(mapcar #'(lambda (x)
				    (micro-eval x env))
				(cdr s))
			env)))))

(defun micro-apply (func args env)
  (progn (m_print "micro-apply    called")
  (cond ((atom func)
	 (cond ((equal func 'm-car) (caar args))
	       ((equal func 'm-cdr) (cdar args))
	       ((equal func 'm-cons) (cons (car args)
					       (cadr args)))
	       ((equal func 'm-atom) (atom (car args)))
	       ((equal func 'm-null) (null (car args)))
	       ((equal func 'm-equal) (equal (car args)
					     (cadr args)))
	       ((equal func 'm-times) (* (car args)
					 (cadr args)))
	       ((equal func 'm-add) (+ (car args)
					 (cadr args)))

	       (t (micro-apply
		   (micro-eval func env)
		   args
		   env))))
	((equal (car func) 'm-definition)
	 (micro-eval (caddr func)
		     (micro-bind (cadr func) args env)))
	((equal (car func) 'm-closure)
	 (micro-eval (caddr func)
		     (micro-bind (cadr func) args
				 (cadddr func)))))))

(defun micro-evalcond (clauses env)
  (progn (m_print "micro-evalcond called")
  (cond ((null clauses) nil)
	((micro-eval (caar clauses) env)
	 (micro-eval (cadar clauses) env))
	(t (micro-evalcond (cdr clauses) env)))))

(defun micro-bind (key-list value-list a-list)
  (progn (m_print "micro-bind     called")
  (cond ((or (null key-list) (null value-list)) a-list)
	(t (cons (list (car key-list) (car value-list))
		 (micro-bind (cdr key-list)
			     (cdr value-list)
			     a-list))))))

(defun micro-value (key a-list)
  (progn (m_print "micro-value    called")
	 (cadr (assoc key a-list))))

(defun micro-setq (variable value a-list)
  (progn (m_print "micro-setq     called")
  (prog (entry)
	(setq entry (assoc variable a-list))
	(setq result (micro-eval value a-list))
	(m_print "   mark1-result") (print result)
	(m_print "   mark2-entry")  (print entry)
	(cond (entry (rplaca (cdr entry) result))
	      (t (rplacd (last a-list) (list (list variable result)))))
	(return result))))

(defun micro-rep ()
  (prog (s env)
	(setq _micro_debug nil)
	(setq env (list (list :_dummy_ 100)))
	
	loop
	(format t ">> ")
	(force-output nil)
	(setq s (read))
	(cond ((atom s)
	       (print (micro-eval s env)))
	      ((equal (car s) 'm-defun)
	       (setq env (cons (list (cadr s)
				     (cons 'm-definition
					   (cddr s)))
			       env))
	       (print (cadr s)))
	      ((equal (car s) 'env)
	       (print env))
	      ((equal (car s) 'debug-on)
	       (setq _micro_debug t))
	      ((equal (car s) 'debug-off)
	       (setq _micro_debug nil))
	      ((equal (car s) 'bye)
	       (return))
	      (t (print (micro-eval s env))))
	(go loop)))

(defun m_print (s)
  (eval-when (:execute)
    (if (eq _micro_debug t)
      (print s))))

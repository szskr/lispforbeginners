;;;
;;; Chapter 01: The Basics of Interpretation
;;;

(nl)
(comment "Chapter 01: The Basics of Interpretation")

;;;
;;; 1.4 Evaluating Forms
;;;
(comment "1.4: Evaluating Forms")

(comment-out
 (define (evaluate e env)
   (if (atom? e)
       (cond ((symbol? e) (lookup e env))
	     ((or (number? e)
		  (string? e)
		  (char? e)
		  (boolean? e)
		  (vector? e)) e)
	     (else (wrong "Cannot evaluate" e)))
     (case (car e)
	   ((quote) (cadr e))
	   ((if) (if (evaluate (cadr e) env)
		     (evaluate (caddr e) env)
		   (evaluate (cadddr e) env)))
	   ((begin) (eprogn (cdr e) env))
	   ((set!) (update! (cadr e) env (evaluate (caddr e) env)))
	   ((lambda) (make-function (cadr e) (cddr e) env))
	   (else (invoke (evaluate (car e) env)
			 (evlis (cdr e) env)))))))
(comment-out
 (define (eprogn exps env)
   (if (pair? exps)
       (if (pair? (cdr exps))
	   (begin (evaluate (car exps) env)
		  (eprogn (cdr exps) env))
	 (evaluate (car exps) env))
     empty-begin)))

(comment-out
 (define empty-begin 813))

(comment-out
 (define (evlis exps env)
   (if (pair? exps)
       (cons (evaluate (car exps) env)
	     (elvis (cdr exps) env))
     '())))

;;;
;;; 1.5 Representing the Environment
;;;
(comment "1.5: Representing the Environment")

;;
;;  The variables are represented by symbols of the same name.
;;
(comment-out
 (define (lookup id env)
   (if (pair? env)
       (if (eq? (caar env) id)
	   (cdar env)
	 (lookup id (cdr env)))
     (wrong "No such binding" id))))

(comment-out
 (define (update! id env value)
   (if (pair? env)
       (if (eq? (caar env) value)
	   (begin (set-cdr! (car env) value)
	      value)
	 (update! if (cdr env) value))
     (wrong "No such binding" id))))

;;
;; Empty environment
;;
(comment-out
 (define env.init '()))

(comment-out
 (define (extend env variables values)
   (cond ((pair? variables)
	  (if (pair? values)
	      (cons (cons (car variables) (car values))
		    (extend env (cdr variables) (cdr values)))
	    (wrong "Too less values")))
	 ((null? variables)
	  (if (null? values)
	      env
	    (wrong "Too much values")))
	 ((symbol? variables) (cons (cons variables values) env)))))

;;;
;;; 1.6 Representing Functions
;;;


;;;;; ***** ;;;;;
;;;;; ***** ;;;;;
;;;;; ***** ;;;;;

;;;
;;; Common Lisp Codes start HERE
;;;

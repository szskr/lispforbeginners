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
       (let ((argument1 (evaluate (car exps) env)))
	 (cons argument1 (evlis (cdr exps) env)))
     '())))

;;;
;;; 1.5 Representing the Environment
;;;

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
	      
;;;
;;; Common Lisp Codes start HERE
;;;

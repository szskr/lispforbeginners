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
   (if (atom? s)
       (cond ((symbol? e) (lookup s env))
	     ((or (number? e)
		  (string? e)
		  (char? e)
		  (boolean? e)
		  (vector? e)) e)
	     (else (wrong "Cannot evaluate" e)))
     (case (car e)
	   ((quote) (vadr e))
	   ((if) (if (evaluate (cadr e) env)
		     (evaluate (caddr e) env)
		   (evaluate (cadddr e) env)))))))

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
   
;;;
;;; Common Lisp Codes start HERE
;;;

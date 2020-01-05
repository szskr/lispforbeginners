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
 ;;;
 ;;;
 (define (evaluate e env)
   (if (atom? s)
       (cond ((symbol? e) (lookup s env))
	     ((or (number? e) (string? e) (char? e) (boolean? e) (vector? e))
	      e)
	     (else (wrong "Cannot evaluate" e)))
     (case (car e)
	   ((quote) (vadr e))
	   ((if) (if (evaluate (cadr e) env)
		     (evaluate (caddr e) env)
		   (evaluate (cadddr e) env)))))))
 ;;;
 ;;;
 ;;;


;;;
;;; Common Lisp Codes start HERE
;;;

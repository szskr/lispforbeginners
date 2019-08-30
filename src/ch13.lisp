;;;
;;; Lisp Internal No.01
;;;

;;
;; eval
;;
(defun eval (form)
  (cond
   
   ;; nil, number, character strings
   ((or (null form) (numberp form) (stringp form)) form)

   ;; symbol
   ((symbolp form) (variable-value form))

   ;; special form
   ((member (car form)
	    '(quote cond setq prog progn prog1 prog2 go let let*
		    if do do* defun defmacro function))
    (eval-special-form form))

   ;;
   ((and (consp (car form))
	 (eq (caar form) 'lambda))
    (apply (car form) (evlis (cdr form))))

   ;;
   ((function-symbol-p (car form))
    (apply (symbol-function (car form))
	   (evlis (cdr form))))

   ;;
   ((macro-symbol-p (car form))
    (eval (apply (macro-function (carform)) (cdrform))))

   (t (error'cannot-evaluate form))))

;;
;; evlis
;;
(defun evlis (args)
  (cond ((null args) nil)
	(t (cons (eval (car args)) (evlis (cdr args))))))
   

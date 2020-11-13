;;
;; Tiny Lisp
;;  「初めての人のためのLISP」第１３講
;;   Version 0.0
;;

;;
;; Tiny-lisp: APIs
;;  t-eval
;;  SPECIAL FORMS
;;    '(t-quote t-cond t-setq t-prog t-progn
;;	t-prog1 t-prog2 t-go t-let t-let*
;;	t-if t-do t-do* t-defun t-defmacro
;;	t-function t-apply)
;;  t-symbol-value
;;  t-makunbound
;;  t-symbol-function
;;  t-set-symbol-function
;;  t-symbol-function-p
;;  t-set-symbol-function
;;  t-fmakunbound
;;  t-function-symbol-p
;;  t-macro-symbol-p
;;  t-macro-function
;;
(setq _special-forms '(t-quote t-cond t-setq t-prog t-progn
			      t-prog1 t-prog2 t-go t-let t-let*
			      t-if t-do t-do* t-defun t-defmacro

			      t-function t-apply))
;;
;; t-eval (p.214)
;;
(defun t-eval (form)
  ;;(print "t-eval")
  (cond
    ;; nil, number, string
    ((or (null form) (numberp form) (stringp form)) form)

    ;; symbol
    ((symbolp form) (_variable-value form))

    ;; special forms
    ((member (car form) _special-forms)
     (_eval-special-form form))

    ;; function call
    ((and (consp (car form)) ; lambda?
	  (eq (caar form) 'lambda))
     (t-apply (car form) (_elvis (cdr form))))

    ((t-function-symbol-p (car form)) ; function?
     (t-apply (symbol-function (car form))
	    (_elvis (cdr form))))

    ;; macro form
    ((t-macro-symbol-p (car form))
     (t-eval (t-apply (t-macro-function (car form)) (cdr from))))

    (t (error 'cannot-evaluate form))
    
    ;; End of Cond
    )

  ;; End of Defun
  )

;;
;; _elvis (p.214)
;;
(defun _evlis (args)
  (cond ((null args) nil)
	(t (cons (t-eval (car args)) (_evlis (cdr args))))))

;;
;; _eval-special-form (p.214)
;; _ev-cond_v1 (p.215)
;; _ev-conv    (p.223)
;; _ev-progn (p.215)
;;
(defun _eval-special-form (form)
  (cond ((eq (car form) 't-quote) (cadr form))
	((eq (car form) 't-cond) (_ev-cond (cdr form)))
	((eq (car form) 't-setq) (_ev-setq (cdr form)))
	((eq (car form) 't-prog) (_ev-prog (cdr form)))
	((eq (car form) 't-progn) (_ev-progn (cdr form)))
	((eq (car form) 't-go) (_ev-go (cdr form)))
	((eq (car form) 't-let) (_ev-let (cdr form)))
	((eq (car form) 't-let*) (_ev-let* (cdr form)))
	((eq (car form) 't-if) (_ev-if (cdr form)))
	((eq (car form) 't-do) (_ev-do (cdr form)))
	((eq (car form) 't-do*) (_ev-do* (cdr form)))
	((eq (car form) 't-defun)
	 (t-set-symbol-function
	  (cadr form)
	  `(lambda ,(caddr form) ,@(cdddr form))))
	((eq (car form) 't-demacro) (_ev-defmacro (cdr form)))
	((eq (car form) 't-function) (_ev-function (cdr form)))
	((eq (car form) 't-apply) (_ev-apply (cdr form)))))

(defun _ev-cond-v1 (clauses)
  (cond  
   ; If no more clauses, then renturn nil
   ((null clauses) nil)

   ; 
   ((t-eval (caar clauses))
    (_ev-progn (cadr clauses)))

   ;
   (t (_ev-cond-v1 (cdr clauses)))))

(defun _ev-cond (clauses)
  (t-let ((p nil))
    (cond ((null clauses) nil)
	  ((setq p (t-eval (caar clauses)))
	   (cond ((null (cdar clauses)) p)
		 (t (_ev-progn (cdar clauses)))))
	  (t (_ev-cond (cdr clauses))))))

(defun _ev-progn (forms)
  (cond
   
   ;; if empty forms, return nil
   ((null forms) nil)

   ;; return the last expression in the forms
   ((null (cdr forms)) (eval (car forms)))

   ;; evaluate expressions in the forms sequetially
   (t (t-eval (car forms)) (_ev-progn (cdr forms)))))

;;
;; Note on "environment"
;;
;;   1. A dictionary for variables: variable <-> it's value
;;   2. A dictionary for function/macrco: To check if a symbol represents function/macro or not.
;;
;;   a. A-list will be used for 1.
;;   b. A set  will be used for 2.
;;
;;   Internal model for a symbol
;;
;;     +--------------+---------------------+
;;     + symbol name  | attribute list      |
;;     +--------------+---------------------+
;;     + global value | function/macro body |
;;     +--------------+---------------------+
;;

;;
;; Functions to be defined
;;  t-symbol-value (p.218)
;;  t-makeunbound (p.218)
;;  t-symbol-function (p.219)
;;  t-set-symbol-function (p.219)
;;  t-fmakunbound (p.219)
;;
(defun t-symbol-value (s)
  (print "Return gloval value of the symbol s"))

(defun t-makunbound (s)
  (print "set the value of the symbol s to nil"))

(defun t-symbol-function (s)
  (print "Return the function definition of the symbol s"))

(defun t-set-symbol-function (s fn)
  (print "Set the value of the symbol s to fn"))

(defun t-fmakunbound (s)
  (print "Set the function defition of the symbol s to nil"))

;;
;; t-function-symbol-p (p.220)
;; t-macro-symbol-p (p.220)
;; t-macro-function (p.220)
;;
(defun t-function-symbol-p (s)
  (let ((fb (and (symbolp s) (t-symbol-function s))))
    (and fb (eq (car fb) 'lambda))))

(defun t-macro-symbol-p (s)
  (let ((fb (and (symbolp s) (t-gosymbol-function s))))
    (and fb (eq (car fb) 'macro))))

(defun t-macro-function (s)
  (and (t-macro-symbol-p s) (t-symbol-function s)))

;;
;; t-local-value (p.222)
;; _loc-val2 (p.222)
;;
(defun t-local-value (s)
  (let ((sv (_loc-val2 s t-env)))
    (conv (sv (cdr sv)) (t 'no-value))))

(defun _loc_val2 (s e)
  (cond ((null e) nil)
	((assoc s (car e)) (assoc s (car e)))
	(t (_loc-val2 s (cdr e))) ))

;;
;; _variable-value (p.224)
;; _loc-val2 (p.224)
;; t-apply (p.224)
;; _eval-body-in-new-environment (p.224)
;; _ev-setq (p.227)
;;
(defun _variable-value (s)
  (let ((_localv nil)
	(_globalv nil))
    (setq _localv (_loc_val2 s t-env))
    (cond (_localv (cdr _localv))
	  (t (setq _globalv (t-symbol-value s))
	     (cond ((neq _globalv 'no-value) _globalv)
		   (t (error 'unbound-variable s)))))))

(defun t-apply (fn args)
  (cond ((t-function-symbol-p fn)
	 (_eval-body-in-new-environment nil fn args))
	((t-lambda-expression-p fn)
	 (_eval-body-in-new-environment nil fn args))
	(t (error 'illegal-function fn))))

(defun _eval-body-in-new-environment (title lambda args)
  (prog2
      (push (cons titile (_pairlis (cadr lambda) args)) env)
      (_ev-progn (cddr lambda))
    (pop t-env)))

(defun _pairlis (x y)
  (cond ((and x y)
	 (cons (cons (car x) (car y))
	       (_pairlis (cdr x) (cdr y)) ))))

(defun _ev-setq (form)
  )

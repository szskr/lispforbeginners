;;
;; Tiny Lisp
;;  「初めての人のためのLISP」第１３講 (original)
;;

(setq special-forms '(quote cond setq prog progn
			      prog1 prog2 go let let*
			      if do do* defun defmacro
			      function apply))
;;
;; eval (p.214)
;;
(defun eval (form)
  (cond
    ;; nil, number, string
    ((or (null form) (numberp form) (stringp form)) form)

    ;; symbol
    ((symbolp form) (variable-value form))

    ;; special forms
    ((member (car form) special-forms)
     (eval-special-form form))

    ;; function call
    ((and (consp (car form)) ; lambda?
	  (eq (caar form) 'lambda))
     (apply (car form) (elvis (cdr form))))

    ((function-symbol-p (car form)) ; function?
     (apply (symbol-function (car form))
	    (elvis (cdr form))))

    ;; macro form
    ((macro-symbol-p (car form))
     (eval (apply (macro-function (car form)) (cdr from))))

    (t (error 'cannoevaluate form))
    
    ;; End of Cond
    )

  ;; End of Defun
  )

;;
;; elvis (p.214)
;;
(defun evlis (args)
  (cond ((null args) nil)
	(t (cons (eval (car args)) (evlis (cdr args))))))

;;
;; eval-special-form (p.214)
;; ev-condv1 (p.215)
;; ev-conv    (p.223)
;; ev-progn (p.215)
;;
(defun eval-special-form (form)
  (cond ((eq (car form) 'quote) (cadr form))
	((eq (car form) 'cond) (ev-cond (cdr form)))
	((eq (car form) 'setq) (ev-setq (cdr form)))
	((eq (car form) 'prog) (ev-prog (cdr form)))
	((eq (car form) 'progn) (ev-progn (cdr form)))
	((eq (car form) 'go) (ev-go (cdr form)))
	((eq (car form) 'let) (ev-let (cdr form)))
	((eq (car form) 'let*) (ev-let* (cdr form)))
	((eq (car form) 'if) (ev-if (cdr form)))
	((eq (car form) 'do) (ev-do (cdr form)))
	((eq (car form) 'do*) (ev-do* (cdr form)))
	((eq (car form) 'defun)
	 (sesymbol-function
	  (cadr form)
	  `(lambda ,(caddr form) ,@(cdddr form))))
	((eq (car form) 'demacro) (ev-defmacro (cdr form)))
	((eq (car form) 'function) (ev-function (cdr form)))
	((eq (car form) 'apply) (ev-apply (cdr form)))))

(defun ev-cond-v1 (clauses)
  (cond
   
   ; If no more clauses, then renturn nil
   ((null clauses) nil)

   ; 
   ((eval (caar clauses))
    (ev-progn (cadr clauses)))

   ;
   (t (ev-cond-v1 (cdr clauses)))))

(defun evcond (clauses)
  (let ((p nil))
    (cond ((null clauses) nil)
	  ((setq p (eval (caar clauses)))
	   (cond ((null (cdar clauses)) p)
		 (t (evprogn (cdar clauses)))))
	  (t (evcond (cdr clauses))))))

(defun ev-progn (forms)
  (cond
   
   ;; if empty forms, return nil
   ((null forms) nil)

   ;; return the last expression in the forms
   ((null (cdr forms)) (eval (car forms)))

   ;; evaluate expressions in the forms sequetially
   (t (eval (car forms)) (ev-progn (cdr forms)))))

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
;;  symbol-value (p.218)
;;  makeunbound (p.218)
;;  symbol-function (p.219)
;;  sesymbol-function (p.219)
;;  fmakunbound (p.219)
;;
(defun symbol-value (s)
  (print "Return gloval value of the symbol s"))

(defun makunbound (s)
  (print "set the value of the symbol s to nil"))

(defun symbol-function (s)
  (print "Return the function definition of the symbol s"))

(defun sesymbol-function (s fn)
  (print "Set the value of the symbol s to fn"))

(defun fmakunbound (s)
  (print "Set the function defition of the symbol s to nil"))

;;
;; function-symbol-p (p.220)
;; macro-symbol-p (p.220)
;; macro-function (p.220)
;;
(defun function-symbol-p (s)
  (let ((fb (and (symbolp s) (symbol-function s))))
    (and fb (eq (car fb) 'lambda))))

(defun macro-symbol-p (s)
  (let ((fb (and (symbolp s) (symbol-function s))))
    (and fb (eq (car fb) 'macro))))

(defun macro-function (s)
  (and (macro-symbol-p s) (symbol-function s)))

;;
;; local-value (p.222)
;; loc-val2 (p.222)
;;
(defun local-value (s)
  (let ((sv (loc-val2 s env)))
    (conv (sv (cdr sv)) (t 'no-value))))

(defun locval2 (s e)
  (cond ((null e) nil)
	((assoc s (car e)) (assoc s (car e)))
	(t (loc-val2 s (cdr e))) ))

;;
;; variable-value (p.224)
;; loc-val2 (p.224)
;; apply (p.224)
;; eval-body-in-new-environment (p.224)
;;

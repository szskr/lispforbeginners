;;
;; Tiny Lisp
;;  「初めての人のためのLISP」第１３講
;;

(setq special-forms '(t-quote t-cond t-setq t-prog t-progn
			      t-prog1 t-prog2 t-go t-let t-let*
			      t-if t-do t-do* t-defun t-defmacro
			      t-function t-apply))
;;
;; t-eval (p.214)
;;
(defun t-eval (form)
  (cond
    ;; nil, number, string
    ((or (null form) (numberp form) (stringp form)) form)

    ;; symbol
    ((symbolp form) (_variable-value form))

    ;; special forms
    ((member (car form) special-forms)
     (_eval-special-form form))

    ;; function call
    ((and (consp (car form)) ; lambda?
	  (eq (caar form) 'lambda))
     (t-apply (car form) (_elvis (cdr form))))

    ((function-symbol-p (car form)) ; function?
     (t-apply (symbol-function (car form))
	    (_elvis (cdr form))))

    ;; macro form
    ((_macro-symbol-p (car form))
     (t-eval (t-apply (_macro-function (car form)) (cdr from))))

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
	 (__set-symbol-function
	  (cadr form)
	  `(lambda ,(caddr form) ,@(cdddr form))))
	((eq (car form) 't-demacro) (_ev-defmacro (cdr form)))
	((eq (car form) 't-function) (_ev-function (cdr form)))
	((eq (car form) 't-apply) (_ev-apply (cdr form)))))

(defun _ev-cond (clauses)
  (cond
   
   ; If no more clauses, then renturn nil
   ((null clauses) nil)

   ; 
   ((t-eval (caar clauses))
    (_ev-progn (cadr clauses)))

   ;
   (t (_ev-cond (cdr clauses)))))

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
;;  __symbol-value (p.218)
;;  __makeunbound (p.218)
;;  __symbol-function (p.219)
;;  __set-symbol-function (p.219)
;;  __fmakunbound (p.219)
;;
(defun __symbol-value (s)
  (print "Return gloval value of the symbol s"))

(defun __makunbound (s)
  (print "set the value of the symbol s to nil"))

(defun __symbol-function (s)
  (print "Return the function definition of the symbol s"))

(defun __set-symbol-function (s fn)
  (print "Set the value of the symbol s to fn"))

(defun __fmakunbound (s)
  (print "Set the function defition of the symbol s to nil"))

;;
;; t-function-symbol-p (p.220)
;; t-macro-symbol-p (p.220)
;; t-macro-function (p.220)
;;
(defun t-function-symbol-p (s)
  (let ((fb (and (symbolp s) (symbol-function s))))
    (and fb (eq (car fb) 'lambda))))

(defun t-macro-symbol-p (s)
  (let ((fb (and (symbolp s) (symbol-function s))))
    (and fb (eq (car fb) 'macro))))

(defun t-macro-function (s)
  (and (t-macro-symbol-p s) (symbol-function s)))

;;
;; Lisp in Lisp
;;   Based on「初めての人のためのLISP」第１３講
;;

;;
;; Tiny-lisp: APIs
;;  t-eval
;;  t-apply
;;  SPECIAL FORMS
;;    '(t-quote t-cond t-setq
;;      t-progn
;;	t-defun t-defmacro
;;	t-function)
;;
;;  tiny-symbol-value
;;  tiny-makunbound
;;  tiny-symbol-function
;;  tiny-set-symbol-function
;;  tiny-symbol-function-p
;;  tiny-set-symbol-function
;;  tiny-fmakunbound
;;  tiny-function-symbol-p
;;  tiny-macro-symbol-p
;;  tiny-macro-function
;;
(setq tiny-data-special-forms
      '(t-quote
	t-cond
	t-setq
	t-progn
	t-defun
	t-defmacro
	t-function))
;;
;; t-eval (p.214)
;;
(defun t-eval (form)
  (cond
    ;; nil, number, string
    ((or (null form) (numberp form) (stringp form)) form)

    ;; symbol
    ((symbolp form) (tiny-variable-value form))

    ;; special forms
    ((member (car form) tiny-data-special-forms)
     (tiny-eval-special-form form))

    ;; function call
    ((and (consp (car form)) ; lambda?
	  (eq (caar form) 't-lambda))
     (t-apply (car form) (tiny-elvis (cdr form))))

    ((tiny-function-symbol-p (car form)) ; function?
     (t-apply (tiny-symbol-function (car form))
	    (tiny-elvis (cdr form))))

    ;; macro form
    ((tiny-macro-symbol-p (car form))
     (t-eval (t-apply (tiny-macro-function (car form)) (cdr from))))

    (t (error 'cannot-evaluate form))
    
    ;; End of Cond
    )

  ;; End of Defun
  )

;;
;; tiny-elvis (p.214)
;;
(defun tiny-evlis (args)
  (cond ((null args) nil)
	(t (cons (t-eval (car args)) (tiny-evlis (cdr args))))))

;;
;; tiny-eval-special-form (p.214)
;; tiny-evcon    (p.223)
;; tiny-ev-progn (p.215)
;;
(defun tiny-eval-special-form (form)
  (cond ((eq (car form) 't-quote) (cadr form))
	((eq (car form) 't-cond) (tiny-evcon (cdr form)))
	((eq (car form) 't-setq) (tiny-evsetq (cdr form)))
	((eq (car form) 't-progn) (tiny-evprogn (cdr form)))
	((eq (car form) 't-defun)
	 (tiny-set-symbol-function
	  (cadr form)
	  `(t-lambda ,(caddr form) ,@(cdddr form))))
	((eq (car form) 't-demacro) (_ev-defmacro (cdr form)))
	((eq (car form) 't-function) (_ev-function (cdr form)))
	((eq (car form) 't-apply) (_ev-apply (cdr form)))))

(defun tiny-evcon (clauses)
  (let ((p nil))
    (cond ((null clauses) nil)
	  ((setq p (t-eval (caar clauses)))
	   (cond ((null (cdar clauses)) p)
		 (t (tiny-evprogn (cdar clauses)))))
	  (t (tiny-evcon (cdr clauses))))))

(defun tiny-evprogn (forms)
  (cond
   ;; if empty forms, return nil
   ((null forms) nil)

   ;; return the last expression in the forms
   ((null (cdr forms)) (eval (car forms)))

   ;; evaluate expressions in the forms sequetially
   (t (t-eval (car forms)) (tiny-evprogn (cdr forms)))))

(defun tiny-symbol-value (s)
  (print "Return gloval value of the symbol s"))

(defun tiny-makunbound (s)
  (print "set the value of the symbol s to nil"))

(defun tiny-symbol-function (s)
  (print "Return the function definition of the symbol s"))

(defun tiny-set-symbol-function (s fn)
  (print "Set the value of the symbol s to fn"))

(defun tiny-fmakunbound (s)
  (print "Set the function defition of the symbol s to nil"))

;;
;; tiny-function-symbol-p (p.220)
;; tiny-macro-symbol-p (p.220)
;; tiny-macro-function (p.220)
;;
(defun tiny-function-symbol-p (s)
  (let ((fb (and (symbolp s) (tiny-symbol-function s))))
    (and fb (eq (car fb) 't-lambda))))

(defun tiny-macro-symbol-p (s)
  (let ((fb (and (symbolp s) (tiny-symbol-function s))))
    (and fb (eq (car fb) 't-macro))))

(defun tiny-macro-function (s)
  (and (tiny-macro-symbol-p s) (tiny-symbol-function s)))

;;
;; tiny-local-value (p.222)
;; tiny-loc-val2 (p.222)
;;
(defun tiny-local-value (s)
  (let ((sv (tiny-loc-val2 s t-env)))
    (conv (sv (cdr sv)) (t 'no-value))))

(defun tiny-loc_val2 (s e)
  (cond ((null e) nil)
	((assoc s (car e)) (assoc s (car e)))
	(t (tiny-loc-val2 s (cdr e))) ))

;;
;; tiny-variable-value (p.224)
;; tiny-loc-val2 (p.224)
;; t-apply (p.224)
;; tiny-eval-body-in-new-environment (p.224)
;; tiny-evsetq (p.227)
;;
(defun tiny-variable-value (s)
  (let ((_localv nil)
	(_globalv nil))
    (setq _localv (tiny-loc_val2 s t-env))
    (cond (_localv (cdr _localv))
	  (t (setq _globalv (tiny-symbol-value s))
	     (cond ((neq _globalv 'no-value) _globalv)
		   (t (error 'unbound-variable s)))))))

(defun t-apply (fn args)
  (cond ((tiny-function-symbol-p fn)
	 (tiny-eval-body-in-new-environment nil fn args))
	((tiny-lambda-expression-p fn)
	 (tiny-eval-body-in-new-environment nil fn args))
	(t (error 'illegal-function fn))))

(defun tiny-eval-body-in-new-environment (title lambda args)
  (prog2
      (push (cons titile (tiny-pairlis (cadr lambda) args)) env)
      (tiny-evprogn (cddr lambda))
    (pop t-env)))

(defun tiny-pairlis (x y)
  (cond ((and x y)
	 (cons (cons (car x) (car y))
	       (tiny-pairlis (cdr x) (cdr y)) ))))

(defun tiny-evsetq (form)
  (let (localv)
    (setq localv (tiny-loc-val2 (car form) t-env))
    (cond (localv
	   (rplacd localv))
	  (t (set-symbol-value
	      (car form)
	      (tiny-eval (cadr form)))))))

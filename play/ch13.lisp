;;
;; eval sketch 
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

   (t (error 'cannot-evaluate form))))

;;
;; evlis
;;
(defun evlis (args)
  (cond ((null args) nil)
	(t (cons (eval (car args)) (evlis (cdr args))))))

;;
;; (WIP) eval-special-form
;;
(defun eval-special-form (form)
  (cond ((eq (car form) 'quote) (cadr form))
	((eq (car form) 'cond) (evcon (cdr form)))
	((eq (car form) 'defun) (set-symbol-function (cadr form)
			       `(lambda ,(caddr form) ,@(caddr form))))
	((eq (car form) 'defmacro) (set-symbol-function (cadr form)
			       `(macro ,(caddr form) ,@(caddr form))))
	((eq (car form) 'setq) (dummy (cdr form)))
	))

;;
;; evcon
;;
(defun evcon (clauses)
  (cond
   ((null clauses) nil)
   ((eval (caar clauses))
    (evprogn (cdar clauses)))
   (t (evcon (cdr clauses)))))

;;
;; evprogn
;;
(defun evprogn (forms)
  (cond
   ((null forms) nil)
   ((null (cdr forms)) (eval (car forms)))
   (t (eval (car forms)) (evprogn (cdr forms)))))

;;
;; function-symbol-p
;;
(defun function-symbol-p (s)
  (let ((fb (and (symbolp s) (symbol-function s))))
    (and fb (eq (car fb) 'lambda))))

;;
;; function-macro-p
;;
(defun macro-symbol-p (s)
  (let ((fb (and (symbolp s) (symbol-function s))))
    (and fb (eq (car fb) 'macro))))

;;
;; macro-function
;;
(defun macro-function (s)
  (and (macro-symbol-p s) (symbol-function s)))

;;
;; stubs
;;
(defun dummy (form)
  (print "(dummy form): called"))

;;
;; debug
;;
(defun h ()
  (print "(h): debug func")
  t)
   

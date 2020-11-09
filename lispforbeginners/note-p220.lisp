;;
;; Tiny Lisp
;;  「初めての人のためのLISP」第１３講
;;

(setq _special-forms '(t-quote t-cond t-setq t-prog t-progn
			      t-prog1 t-prog2 t-go t-let t-let*
			      t-if t-do t-do* t-defun t-defmacro
			      t-function t-apply))

;;
;; Notes on p.220
;;
(defun foo (str1 str2)
  (print str1)
  (print str2)
  t)

(setq form '(defun foo(str1 str2)
	      (print str1)
	      (print str2)
	      t))

(defun show0()
  `(lambda ,(caddr form) ,@(cdddr form)))

(defun show1()
  (cons 'lambda (cons (caddr form) (cdddr form))))


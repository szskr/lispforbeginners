;;;
;;; OnLisp: Chapter 07
;;;

(defun l7 () (load "./olCh07.lisp"))
;;
;; Q: Why setq is quoted as 'setq ?
;;  ;; Remove the quote and try it. Then think about it.
;;
(defmacro nil! (var)
  (list 'setq var nil))

;;
;;
(setq a1 (equal '(a b c) `(a b c)))
(setq a2 (equal '(a b c) (list 'a 'b 'c)))

(setq a 1 b 2 c 3)
(setq a3 `(a ,b c))
(setq a4 `(a (,b c)))

(setq a5 `(a b ,c (',(+ a b c)) (+ a b) 'c '((,a ,b))))

;;
;; Macro definition for nil! can be written as follows:
;;
(defmacro nil!! (var)
  `(setq ,var nil))

;;
;; ' or quote
;;
(defmacro nif (expr pos zero neg)
  `(case (truncate (signum ,expr))
	 (1 ,pos)
	 (0 ,zero)
	 (-1 ,neg)))

(defmacro nnif (expr pos zero neg)
  (list 'case
	(list 'truncate (list 'signum expr))
	(list 1 pos)
	(list 0 zero)
	(list -1 neg)))

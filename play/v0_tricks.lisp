;;;
;;; Small tricks (V0)
;;;

(defun lv0 ()
  (load "./v0_tricks.lisp"))
  
;;
;; quote it
;;
(defun quote-it (x)
  (list 'quote x))

(defmacro m-quote-it (x)
  (list 'quote x))

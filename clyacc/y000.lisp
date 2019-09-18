;;;
;;; Prerequisites
;;;

(defun lm () (load "./y000.lisp"))
  
(deftype index () '(unsigned-byte 14))
(deftype signed-index () '(signed-byte 15))

;;
;; function arguments
;;   &optional
;;   &rest
;;   &key
;;
(defun foo_opt (a b &optional (c 100) (d 200))
  (format t "a = ~a, b = ~a, c = ~a, d = ~a" a b c d))

(defun foo_rest (a &rest values)
  (format t "a = ~a values = ~a" a values))

(defun foo_key (&key a b c d)
  (format t "a = ~a b= ~a  c = ~a d = ~a" a b c d))

(defun foo_key_def (&key (a 10) b (c 100) d)
    (format t "a = ~a b= ~a  c = ~a d = ~a" a b c d))
 

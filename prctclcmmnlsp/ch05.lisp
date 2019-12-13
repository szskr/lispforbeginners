;;
;; Chapter 05: Functions
;;

(defun foo (a b &optional c d)
  (list a b c d))
(format t "(foo 1 2)     = ~a~%" (foo 1 2))
(format t "(foo 1 2 3)   = ~a~%" (foo 1 2 3))
(format t "(foo 1 2 3 4) = ~a~%" (foo 1 2 3 4))
(format t "~%")

(defun foo-1 (a &optional (b 0))
  (list a b))
(format t "(foo-1 1)     = ~a~%" (foo-1 1))
(format t "(foo-1 1 2)   = ~a~%" (foo-1 1 2))
(format t "~%")

(defun foo-2 (a &optional (b 0 b-supplied-p))
  (list a b b-supplied-p))
(format t "(foo-2 1)     = ~a~%" (foo-2 1))
(format t "(foo-2 1 2)   = ~a~%" (foo-2 1 2))
(format t "~%")

(defun foo-3 (&key a b c)
  (list a b c))
(format t "(foo-3 :a 1)           = ~a~%" (foo-3 :a 1))
(format t "(foo-3 :b 2)           = ~a~%" (foo-3 :b 2))
(format t "(foo-3 :a 1 :b 2 :c 3) = ~a~%" (foo-3 :a 1 :b 2 :c 3))
(format t "~%")

(defun foo-4 (&key (a 0) (b 10) (c (+ a b)))
  (list a b c))
(format t "(foo-4 :a 1)             = ~a~%" (foo-4 :a 1))
(format t "(foo-4 :b 2)             = ~a~%" (foo-4 :b 2))
(format t "(foo-4 :a 1 :b 2 :c 100) = ~a~%" (foo-4 :a 1 :b 2 :c 100))
(format t "~%")

(defun foo-5 (a b &rest params)
  (list a b params))
(format t "(foo-5 1 2)         = ~a~%" (foo-5 1 2))
(format t "(foo-5 1 2 3)       = ~a~%" (foo-5 1 2 3))
(format t "(foo-5 1 2 3 4)     = ~a~%" (foo-5 1 2 3 4))
(format t "~%")

(defparameter *fn5-1* (let ((count 0)) #'(lambda () (setf count (+ 1 count))))) ;; Closure!

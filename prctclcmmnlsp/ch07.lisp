;;
;; Chapter 07: Macros: Standard Control Constructs
;;

(nl)
(nl)
(chap07)
(comment "Chapter 07")
(nl)

;;;
;;; Quote, Back Quote, COMMA and ,@
;;;
(comment "Quote, Back Quote, COMMA and ,@")
(format t "'(1 2 3) = ~a~%" '(1 2 3))
(format t "'(1 2 (+ 1 2)) = ~a~%" `(1 2 (+ 1 2)))
(format t "`(1 2 3) = ~a~%" `(1 2 3))
(format t "'(1 2 (+ 1 2)) = ~a~%" `(1 2 (+ 1 2)))
(format t "'(1 2 (+ 1 2)) = ~a~%" `(1 2 ,(+ 1 2)))
(nl)
(format t "`(1 2 (list a b)) = ~a~%" `(1 2 (list  b)))
(format t "`(1 2 ,(list 'a 'b)) = ~a~%" `(1 2 ,(list 'a 'b)))
(format t "`(1 2 ,@(list 'a 'b)) = ~a~%" `(1 2 ,@(list 'a 'b)))
(nl)
(defun fp-07-01()
    `(list 1 2))
(format t "(fp-07-01) = ~a~%" (fp-07-01))

(defmacro mp-07-01()
  `(list 1 2))
(format t "(mp-07-01) = ~a~%" (mp-07-01))

(defun fp-07-02 (x y)
  `(,(list x y) ,@(list `(,(+ x y) 'a 'b))))
(format t "(fp-07-2 1 2) = ~a~%" (fp-07-02 1 2))

(defmacro mp-07-02 (x y)
  `'(,(list x y) ,@(list `(,(+ x y) 'a 'b))))
(format t "(mp-07-2 1 2) = ~a~%" (mp-07-02 1 2))
(nl)
;;
;;
;;
(defun sum1toN (n)
  (let ((s 0))
    (do ((x 0 (1+ x)))
	((> x n) s)
	(format t "x=~a s=~a ~%" x s)
	(setf s (+ s x)))))

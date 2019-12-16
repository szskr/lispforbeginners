;;
;; Chapter 08: Macros: Defining Your Own
;;

(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number
	when (primep n) return n))

(defun print-primes (from to)
  (do ((p (next-prime from) (next-prime (1+ p))))
      ((> p to))
      (format t "~d " p)))

(if (equal (first '(1 2 3)) 1)
    (format t "The function first picks up the first element of the given list"))

(defmacro do-primes-0 ((var start end) &body body)
  (let ((ending-value-name (gensym)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
	 ,@body)))

(defmacro with-gensyms-1 ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro do-primes ((var start end) &body body)
  (with-gensyms-1 (ending-value-name)
     `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
	 ,@body)))

;;
;; MACRO-WRITING MACROs
;;   with-gensyms
;;   once-only
;;

;;
;; once-only :: Figure how this works later!
;;
(defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop for n in names collect (gensym))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
	  ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g)))
	     ,@body)))))



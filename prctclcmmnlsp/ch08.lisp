;;
;; Chapter 08: Practical: Macros: Defining Your Own
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

(defmacro do-primes ((var start end) &body body)
  (let ((ending-value-name (gensym)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
	 ,@body)))

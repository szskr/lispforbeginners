;;
;; Chapter 08: Macros: Defining Your Own
;;

(nl)
(nl)
(chap08)
(comment "Chapter 08")
(nl)

;;
;; Warm Ups
;;
(defmacro when-08 (condition &rest body)
  `(if ,condition
       (progn ,@body)))

(defun foo-08-01 (x)
  (when-08 (> x 10)
    (print 'big)))

(format t "(foo-08-01 100): ~a~%" (foo-08-01 100))
(nl)

;;;
;;; Tools
;;;
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

;;;
;;; DEFMACRO
;;;
;;;  The steps to writing a macro are as follows:
;;;    1. Write a sample call to the macro and the code it should expand into, or vice versa.
;;;    2. Write code that generates the handwritten expansion from the arguments in the
;;;       sample call.
;;;    3. Make sure the macro abstraction doesn't "leak".
;;;

;;;
;;; Sample Macro: do-primes
;;;
;;; 1. Sample Call
;;;    (do-primes (p 0 19)
;;;      (format t "~d " p)
;;;
;;;    will output: 2 3 5 7 11 13 17 19
;;;

;;;
;;; 2. Hand written expansion could be:
;;;    (do ((p (next-prime 0) (next-prime (1+ p))))
;;;        ((> p 19))
;;;      (format t "~d " p))

;;;
;;; Macro Parameters:
;;;  The do-primes macro could be defined with two parameters.
;;;  The first parameter to hold the list, and the second, &rest, to hold the body form.
;;;
;;; The first macro could be as follow:

(defmacro do-primes-1 (var-and-range &rest body)
  (let ((var (first var-and-range))
	(start (second var-and-range))
	(end (third var-and-range)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
	 ((> ,var ,end))
	 ,@body)))


;;
;; MACRO-WRITING MACROs
;;   with-gensyms
;;   once-only
;;

(defmacro do-primes-10 ((var start end) &body body)
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
;; once-only :: Figure how this works later!
;;
(defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop for n in names collect (gensym))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
	  ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g)))
	     ,@body)))))


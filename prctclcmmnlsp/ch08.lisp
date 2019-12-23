;;
;; Chapter 08: Macros: Defining Your Own
;;

(nl)
(chap08)
(comment "Chapter 08")

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

;(if (equal (first '(1 2 3)) 1)
;    (format t "The function first picks up the first element of the given list"))
(nl)

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
;;; Implementations of do-primes
;;;
;;;; do-primes-1 - simple implementation
;;;; do-primes-2 - simple implementation using DESTRUCTURING PARAMETERS
;;;; do-primes-3 - Introduced a local variable ending-value. Should change the evaluation order.
;;;; do-primes-4 - Changed the evaluation order properly, however, variable name crash could occur.
;;;; do-primes-5 - Use GENSYM to generate local variable symbol's name
;;;;

;;;
;;; Macro Parameters:
;;;  The do-primes macro could be defined with two parameters.
;;;  The first parameter to hold the list, and the second, &rest, to hold the body form.
;;;

;;;
;;; The first macro could be as follow:

(defmacro do-primes-1 (var-and-range &rest body)
  (let ((var (first var-and-range))
	(start (second var-and-range))
	(end (third var-and-range)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
	 ((> ,var ,end))
	 ,@body)))

(comment "(do-primes-1 (p 0 19) (format t \"~d \" p))")
(do-primes-1 (p 0 19) (format t "~d " p))
(nl)

;;
;; DO-PRIMES-1 can be modifined using DESTRUCTURING PARAMETERS
;;
(nl)
(comment "DESTRUCTURING PARAMETERS")
(defmacro do-primes-2 ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
       ((> ,var ,end))
       ,@body))

(comment "(do-primes-2 (p 0 19) (format t \"~d \" p))")
(do-primes-2 (p 0 19) (format t "~d " p))
(nl)

(comment "macroexpand-1: (do-primes-2)")
(macroexpand-1 '(do-primes-2 (p 0 19) (format t "~d " p)))
(nl)

;;;
;;; do-primes-2 has bugs: See the following macro expansions.
;;;

;;;
;;; [202]> (macroexpand-1 '(do-primes-2 (p 0 19) (format t "~d " p)))
;;; (DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P))))
;;;     ((> P 19))
;;;    (FORMAT T "~d " P)) 
;;;

;;; [208]> (macroexpand-1 '(do-primes-1 (p 0 (random 100)) (format t "~d " p)))
;;; (DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P))))
;;;     ((> P (RANDOM 100)))
;;;    (FORMAT T "~d " P))
;;;
(comment "(do-primes-2 (p 0 (random 100)) (format t \"~d \" p))")
(do-primes-2 (p 0 (random 100)) (format t "~d " p))
(nl)
(nl)

(defmacro do-primes-3 ((var start end) &body body)
  `(do ((ending-value ,end)
	(,var (next-prime ,start) (next-prime (1+ ,var))))
       ((> ,var ending-value))
       ,@body))

(comment "(do-primes-3 (p 0 19) (format t \"~d \" p))")
(do-primes-3 (p 0 19) (format t "~d " p))
(nl)
(nl)

(defmacro do-primes-4 ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	(ending-value ,end))
       ((> ,var ending-value))
       ,@body))

(comment "(do-primes-4 (p 0 19) (format t \"~d \" p))")
(do-primes-4 (p 0 19) (format t "~d " p))
(nl)

;;;
;;; See the expansion below.
;;;

;;; [8]> (macroexpand-1 '(do-primes-4 (ending-value 0 19) (format t "~d " ending-value)))
;;; (DO ((ENDING-VALUE (NEXT-PRIME 0) (NEXT-PRIME (1+ ENDING-VALUE)))
;;;      (ENDING-VALUE 19))
;;;     ((> ENDING-VALUE ENDING-VALUE))
;;;  (FORMAT T "~d " ENDING-VALUE))

;;;
;;; GENSYM
;;;
(nl)
(comment "Going to use GENSYM")
(format t "(gensym) = ~a~%" (gensym))
(nl)

;;;
;;; do-primes with gensym
;;; 
(defmacro do-primes-5 ((var start end) &body body)
  (let ((ending-value-name (gensym)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
	 ,@body)))

(comment "((do-primes-5 (p 0 19) (format t \"~d \" p))")
(do-primes-5 (p 0 19) (format t "~d " p))
(nl)

;;; [16]> (macroexpand-1 '(do-primes-5 (p 0 19) (format t "~d " p)))
;;; (DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P)))
;;;      (#:G3573 19))
;;;     ((> P #:G3573))
;;;    (FORMAT T "~d " P))
;;;

(comment "((do-primes-5 (ending-value-name 0 19) (format t \"~d \" p))")
(do-primes-5 (ending-value-name 0 19) (format t "~d " ending-value-name))
(nl)

;;; [18]> (macroexpand-1 '(do-primes-5 (ending-value 0 19) (format t "~d " ending-value)))
;;; (DO ((ENDING-VALUE (NEXT-PRIME 0) (NEXT-PRIME (1+ ENDING-VALUE)))
;;;      (#:G3620 19))
;;;     ((> ENDING-VALUE #:G3620))
;;;    (FORMAT T "~d " ENDING-VALUE))
;;;

;;; [22]> (macroexpand-1 '(do-primes-5 (ending-value-name 0 19) (format t "~d " ending-value-name)))
;;; (DO ((ENDING-VALUE-NAME (NEXT-PRIME 0) (NEXT-PRIME (1+ ENDING-VALUE-NAME)))
;;;      (#:G3701 19))
;;;     ((> ENDING-VALUE-NAME #:G3701))
;;;    (FORMAT T "~d " ENDING-VALUE-NAME))
;;;

;;;
;;; OK, do-primes-5 could be a FCS, first custmer ship, quality.
;;;

;;
;; MACRO-WRITING MACROs
;;   with-gensyms
;;   once-only
;;

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


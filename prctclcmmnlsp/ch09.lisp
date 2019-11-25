;;
;; Chapter 09: Practical: Building a Unit Test Framework
;;

;;
;; Warm ups
;;
(setf ll (loop for i below 5 collect i))

(defmacro echo (f)
  `(format t "~a: ~a" ,f ',f))

(defmacro isprime (n)
  `(format t "~:[PRIME~;Non-PRIME~] ~a" (not (primep ,n)) ,n))

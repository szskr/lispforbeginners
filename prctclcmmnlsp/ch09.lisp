;;
;; Chapter 09: Practical: Building a Unit Test Framework
;;

;;
;; LOOP
;;
(setf ll (loop for i below 5 collect i))

;;
;; my echo: chapter 09 version
;;
(defmacro echo (f)
  `(format t "~a: ~a" ,f ',f))

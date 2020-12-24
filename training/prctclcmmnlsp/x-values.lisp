;;;
;;; Values/Multiple-values-bind
;;;

(comment "Values/Multiple-values-bind and their family")
(nl)

(comment "The function truncate returns two values.~%")
(comment "The multiple-value-bind() macro can be used to capture multi-values returned.")
(comment "Here is an example:")
(format t "(truncate 17.1234567) = ~a~%" (truncate 17.123))
(format t "(multiple-value-bind (int frac) (truncate 17.123)
		      (list int frac)) = ~a~%"
	(multiple-value-bind (int frac) (truncate 17.123)
			     (list int frac)))

(defun powers (x)
  (values x (sqrt x) (* x x)))

(multiple-value-bind (base root square) (powers 4)
		     (list base root square))

(defun m-powers (x)
  (multiple-value-bind (base root square) (powers x)
		     (list base root square)))

(defun m-truncate (x)
  (multiple-value-bind (int frac) (truncate x)
		       (list int frac)))

;;
;; Oppotunities for writing useful macros here
;;

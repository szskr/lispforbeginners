;;
;; Chapter 07: Standard Control Constructs
;;

(defun sum1toN (n)
  (let ((s 0))
    (do ((x 0 (1+ x)))
	((> x n) s)
	(format t "x=~a s=~a ~%" x s)
	(setf s (+ s x)))))

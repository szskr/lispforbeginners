;;
;; Chapter 20: The Special Operators
;;

(defun global_fun ()
  (format t "global_fun() called~%")
  ;;
  ;; local functions defined in flet:

  (format t "going to call function in the flet():~%")
  (flet ((f1 ()
	     (format t "f1(): called.~%"))
	 (f2 ()
	     (format t "f2(): cqlled.~%")))
	(f1)
	(f2))

  (format t "~%")
  (format t "going to call function in the lebels():~%")
  (labels ((lf1()
	       (format t "lf1(): called.~%"))
	   (lf2()
	       (format t "lf2(): called.~%")))
	  (lf1)
	  (lf2)))

(global_fun)

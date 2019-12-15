;;
;; Chapter 20: The Special Operators
;;

;;;
;;; flet and labels
;;;
(defun global_fun ()
  (format t "global_fun() called~%")
  ;;
  ;; local functions defined in flet:
  ;;
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

;;;
;;; Local Flow of Control
;;;
(defun blk ()
  (format t "In function blk().~%")
  (block block-1
	 (format t "In block-1~%")
	 (block block-2
		(format t "This is block-2 in BLOCK.~%")))
  (format t "Out b().~%"))

(blk)
  


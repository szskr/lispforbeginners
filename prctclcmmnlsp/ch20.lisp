;;
;; Chapter 20: The Special Operators
;;

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
(nl)

;;;
;;; Local Flow of Control
;;;
(defun blk-1 ()
  (format t "In function blk-1().~%")
  (block block-1
	 (format t "In block-1~%")
	 (block block-2
		(format t "This is block-2 in BLOCK.~%")))
  (format t "Out blk-1().~%"))
(blk-1)
(nl)

(defun blk-2 ()
  (format t "In function blk-2(): Nameless BLOCK.~%")
  (block ;; NAMELESS!
	 (format t "In NAMELESS BLOCK~%")
	 (block block-2
		(format t "This is block-2 in BLOCK.~%")))
  (format t "Out blk-2().~%"))
(blk-2)
(nl)

(defun tag-1 ()
  (format t "In tag-1():")
  (tagbody
   top
   (print 'hello)
   (when (plusp (random 10))
     (go top)))
  (nl)
  (format t "Out tag-1():"))
(tag-1)
(nl)
(nl)

;;;
;;; Unwinding Stack
;;;
(defun foo-20 ()
  (format t "Entering foo-20~%")
  (block a
	 (format t " Entering BLOCK a~%")
	 (bar-20 #'(lambda ()
		     (format t "    ENTERING LAMBDA~%")
		     (format t "    LEAVING  from BLOCK a(1)~%")
		     (return-from a)))
	 (format t " Leaving BLOCK a(2)~%"))
  (format t "Leaving foo-20~%"))

(defun bar-20 (fn)
  (format t "  Entering bar-20~%")
  (baz fn)
  (format t "  Leaving bar-20~%"))

(defun baz (fn)
  (format t "   Entering baz~%")
  (funcall fn)
  (format t "   Leaving baz~%"))
(foo-20)

;;;
;;; Catch and Throw
;;;
(nl)
(format t "N: Catch and Throw~%")

(defparameter *obj21* (cons nil nil)); Some arbitary object

(defun foo-21 ()
  (format t "Entering foo-21~%")
  (catch *obj21*
    (format t " Entering CATCH~%")
    (bar-21)
    (format t " Leaving CATCH~%"))
  (format t "Leaving foo-21~%"))

(defun bar-21 ()
  (format t " Entering bar-21~%")
  (baz-21)
  (format t " Leaving bar-21~%"))

(defun baz-21 ()
  (format t "  Entering baz-21~%")
  (throw *obj21* nil)
  (format t "  Leaving  baz-21~%"))
(foo-21)


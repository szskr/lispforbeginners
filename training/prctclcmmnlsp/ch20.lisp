;;
;; Chapter 20: The Special Operators
;;
(nl)
(comment "Chapter 20")
(chap20)
(nl)

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
  (block blk ;; NAMELESS! /* CLISP ok. SBCL does not allow nameless BLOCK */
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
(comment  "Catch and Throw")

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

;;;
;;; unwind-protect
;;;
(comment "Unwind-protect")

(defun AmIeven (num)
  (format t "Entering AmIeven: ~a~%" num)
  (unwind-protect (+ 1 num)
    (format t "unwinding: Leaving AmIeven~%"))
  (format t "Leaving AmIeven~%"))

(AmIeven 100)
(nl)
(AmIeven 101)
(nl)

;;;
;;; Multiple Values
;;;
(comment "Function values")

(comment "(values)")
(values)
(nl)

(comment "(values 1 2)")
(values 1 2)
(format t "VAL=~a~%" (multiple-value-bind (x y) (values 1 2)
		     (+ x y)))
(nl)

(comment "(values 1 2)")
(values 1 2 3)

(myformat "(multiple-value-bind (x y z) (values 10 20 30) (list (+ x y z) 100 200)) = ~a~%"
	  (multiple-value-bind (x y z) (values 10 20 30) (list (+ x y z) 100 200)))

(defmacro my-values (x y z)
  `(multiple-value-bind (_XX_ _YY_ _ZZ_) (values ,x ,y ,z) (list (+ _XX_ _YY_ _ZZ_) 100 200)))
(nl)

;;;
;;; EVAL-WHEN
;;;
(comment "EVAL-WHEN")
(nl)

(load "./ch20.f1.lisp")
(compile-file "./ch20.f1.lisp")
(main20-01)

(comment "You Need To Come Back Here Later")

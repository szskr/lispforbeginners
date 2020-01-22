;;;
;;;
;;;

(eval-when
 (:compile-toplevel
  :load-toplevel
  :execute)

 (format t "*** RunAtCompile-time ***~%")
 (defun run-at-compile-time ()
   (print 'I-am-called-at-compile-time)
   nil))

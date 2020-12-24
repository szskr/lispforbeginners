;;;
;;;
;;;
(defpackage :prcl.ch21.01
  (:use :common-lisp))

(in-package :prcl.ch21.01)

(defun hello ()
  (format t "hello: ~a~%" *package*))

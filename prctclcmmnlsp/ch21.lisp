;;
;; Chapter 21: Programming in the Large: Package and Symbols
;;

(nl)
(nl)
(chap21)
(comment "Chapter 21")
(nl)

*package*     ;; The current package
(format t "The current package is ~a " *package*)
(nl)

(format t "~a~%" (symbol-name :foo))
(format t "~a~%" (symbol-name 'foo-bar))
(format t "~a~%" (gensym))

(nl)
(defvar *x21* 10)
(format t "*x21* = ~a~%" *x21*)
(format t "common-lisp-user::*x21* = ~a~%" common-lisp-user::*x21*)
common-lisp-user::*x21*

;;;
;;; Defining Your Own Packages
;;;

(defpackage :prcl.ch21.01
  (:use :common-lisp))

(defpackage :prcl.ch21.02)

(in-package :prcl.ch21.01)

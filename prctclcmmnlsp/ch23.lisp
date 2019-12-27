;;
;; Chapter 23: Practical: A Spam Filter
;;

(nl)
(nl)
(chap23)
(comment "Chapter 23")
(nl)

;;
;;
;;
(defpackage :spam
  (:use :common-lisp)
  (:export :classify))

(in-package :spam)

(defun classify (text)
  (classification (score (extract-features text))))

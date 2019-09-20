;;
;; Preparation for analyzing yacc.lisp:
;;;     PART 1:PRODUCTION
;;

(defun y100 () (load "./y100.lisp"))
#-CMU
(defun required-argument () (error "A required argument was not supplied"))

#-CMU
(declaim (inline memq))

#-CMU
(defun memq (item list)
  "MEMBER :TEST #'EQ"
  (member item list :test #'eq))

(deftype index () '(unsigned-byte 14))
(deftype signed-index () '(signed-byte 15))

;;;
;;; Productions
;;;

(defstruct (production
             (:constructor make-production (symbol derives
                                            &key action action-form))
             (:print-function print-production))
  (id nil :type (or null index))
  (symbol (required-argument) :type symbol)
  (derives (required-argument) :type list)
  (action #'list :type function)
  (action-form nil))

(defun print-production (p s d)
  (declare (type production p) (stream s) (ignore d))
  (print-unreadable-object (p s :type t)
    (format s "~S -> ~{~S~^ ~}" (production-symbol p) (production-derives p))))

(declaim (inline production-equal-p))
(defun production-equal-p (p1 p2)
  "Equality predicate for productions within a single grammar"
  (declare (type production p1 p2))
  (eq p1 p2))

(declaim (inline production<))
(defun production< (p1 p2)
  "Total order on productions within a single grammar"
  (declare (type production p1 p2))
  (< (production-id p1) (production-id p2)))

;;;
;;; Experiments y100
;;;
(setq *p0* (make-production 'p0 '(S E)))

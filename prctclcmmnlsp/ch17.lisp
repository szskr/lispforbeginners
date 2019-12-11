;;
;; Chapter 17: Object Reorientation: Classes
;;

;;;
;;; Slot Specifiers
;;;

(defclass bank-account-0 ()
  (customer-name
   balance))

(defclass checking-account-0 (bank-account-0) ())
(defclass savinging-account-0 (bank-account-0) ())

(defparameter *account-0* (make-instance 'bank-account-0))
(setf (slot-value *account-0* 'customer-name) "John Doe")
(setf (slot-value *account-0* 'balance) 1000)
(format t "account = ~a~%" *account-0*)
(format t "customer-name = ~a~%" (slot-value *account-0* 'customer-name))
(format t "balance       = ~a~%" (slot-value *account-0* 'balance))

;;;
;;; Object Initialization
;;;   1) three ways to control the initial values of slots
;;;    1.1) :initarg option
;;;    1.2) :initform option
;;;    1.3) by definig a method on the generic function INITIALIZE-INSTANCE,
;;;                                                     which is called by make-instance
;;;



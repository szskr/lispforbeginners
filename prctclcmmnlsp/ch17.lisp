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
(format t "account-0 = ~a~%" *account-0*)
(format t "customer-name = ~a~%" (slot-value *account-0* 'customer-name))
(format t "balance       = ~a~%" (slot-value *account-0* 'balance))
(format t "~%")

;;;
;;; Object Initialization
;;;   1) three ways to control the initial values of slots
;;;    1.1) :initarg option
;;;    1.2) :initform option
;;;    1.3) by definig a method on the generic function INITIALIZE-INSTANCE,
;;;                                                     which is called by make-instance
;;;

(defclass bank-account-1 ()
  ((customer-name
    :initarg :customer-name)
   (balance
    :initarg :balance
    :initform 10)))

(defparameter *account-1*
  (make-instance 'bank-account-1
		 :customer-name "John Doe"
		 :balance 1000))
(format t "account-1 = ~a~%" *account-1*)
(format t "customer-name = ~a~%" (slot-value *account-1* 'customer-name))
(format t "balance       = ~a~%" (slot-value *account-1* 'balance))
(format t "~%")

(defparameter *account-11*
  (make-instance 'bank-account-1
		 :customer-name "John Doe"))
(format t "account-11 = ~a~%" *account-11*)
(format t "customer-name = ~a~%" (slot-value *account-11* 'customer-name))
(format t "balance       = ~a~%" (slot-value *account-11* 'balance))
(format t "~%")

;;
(defvar *account-numbers* 0)
(defclass bank-account-2 ()
  ((customer-name
    :initarg :customer-name
    :initform (error "Must supply a customer name!~%"))
   (balance
    :initarg :balance
    :initform 100)
   (account-number
    :initform (incf *account-numbers*))))

(defparameter *account-2*
  (make-instance 'bank-account-2
		 :customer-name "John Doe"))
(format t "account-2 = ~a~%" *account-2*)
(format t "customer-name = ~a~%" (slot-value *account-2* 'customer-name))
(format t "balance       = ~a~%" (slot-value *account-2* 'balance))
(format t "~%")

(format t "account-numbers = ~a~%" *account-numbers*)

;;
;;
(defclass bank-account-3 ()
  ((customer-name
    :initarg :customer-name
    :initform (error "Must supply a customer name!~%"))
   (balance
    :initarg :balance
    :initform 100)
   (account-number
    :initform (incf *account-numbers*))
   account-type))

(defparameter *account-3*
  (make-instance 'bank-account-3
		 :customer-name "John Doe"))
(setf (slot-value *account-3* 'account-type) :gold)
(format t "account-3 = ~a~%" *account-3*)
(format t "customer-name = ~a~%" (slot-value *account-3* 'customer-name))
(format t "balance       = ~a~%" (slot-value *account-3* 'balance))
(format t "account-type  = ~a~%" (slot-value *account-3* 'account-type))
(format t "~%")

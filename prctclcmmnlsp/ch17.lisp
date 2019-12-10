;;
;; Chapter 17: Object Reorientation: Classes
;;

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

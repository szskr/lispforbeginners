;;
;; Chapter 16: Object Reorientation: Generic Functions
;;

;;
;; A generic function is generic in the sense that it can accept any objectsas arguments.
;; However, a generic function can't actuallt do anything.
;;  The actual implementation has to be provided by METHODS. Each method provides provides an
;;  implementation of the generic function for the particular claees of arguments.
;;  Methods DO NOT belong to the clsses. They belong to the generic function!
;;
;; Methods indicatee what kinds of arguments they can handle by SPECIALIZING the rquired
;; parameters defined by the generic function.
;;

;;
;;  Defgeneric and Defmethod (p.193-195)
;;
(defclass bank-account ()
  (balance))

(defclass checking-account (bank-account) ())
(defclass saving-account (bank-account) ())
(defclass proxy-account () ())

(defgeneric withdraw (account amount)
  (:documentation "Withdraw the specified amount from the account.
Signal an error if the current balance is less than amount."))

(defmethod withdraw ((account bank-account) amount)
  (when (< (balance account) amount)
    (error "Account overdrqwn."))
  (setf (slot-value account 'balance) (- (balance account) amount)))

(defmethod withdraw ((account checking-account) amount)
  (let ((overdraft (- amount (balance account))))
    (when (plusp overdraft)
      (withdraw (overdraft-account account) overdraft)
      (setf (slot-value account 'balance) (+ (balance account) overdraft)))
    (call-next-method)))

(defmethod withdraw ((proxy proxy-account) amount)
  (withdraw (proxied-account proxy) amount))

(defun balance (account)
  (slot-value account 'balance))

(defun overdraft-account (account)
  *ba*)

(defun proxied-account (proxy)
  *ba*)

(setf *ba* (make-instance 'bank-account))
(setf *ca* (make-instance 'checking-account))
(setf *sa* (make-instance 'saving-account))
(setf *pa* (make-instance 'proxy-account))

(setf (slot-value *ba* 'balance) 1000)
(setf (slot-value *ca* 'balance) 100)
(setf (slot-value *sa* 'balance) 500)

;;
;; Method Combination (p.196-p.197)
;; The Standard Method Combination
;;
(defclass ch16 ()
  (var16))

(defclass ch16sct01 (ch16) ())

(defgeneric ch16-hello (cls)
  (:documentation "Experiments"))

(setf *ch16* (make-instance 'ch16))
(setf *ch16sct01* (make-instance 'ch16sct01))

(defmethod ch16-hello :before  ((cls ch16))
  (format t "ch16-hello: :before :GenericTop~%"))

(defmethod ch16-hello :after  ((cls ch16))
  (format t "ch16-hello: :after :GenericTop~%"))

(defmethod ch16-hello :around  ((cls ch16))
  (format t "ch16-hello: :around :GenericTop~%")
  (call-next-method))
  
(defmethod ch16-hello ((cls ch16))
  (format t "ch16-hello: Generic TopClass~%"))

(defmethod ch16-hello ((cls ch16sct01))
  (format t "ch16-hello: ch16sct01~%")
  (call-next-method))

;;
;; Other Method Combinations
;;  1) Nine other buit-n methid known as SIMPLE built-in method combinations
;;  2) Custome method: fairly esoteric feature and beyond the scope of this book
;;

;;
;;Multimethods
;;
(defclass x-inum () ())
(defclass y-inum () ())
(defclass x-rnum () ())
(defclass y-rnum () ())

(defgeneric multiply (x y)
  (:documentation
   "Produce a product by given x and y"))

(defmethod multiply ((x x-inum) (y y-inum))
  (format t "x-Inum times y-Inum is ~a ~a~%" x y))

(defmethod multiply ((x x-inum) (y y-rnum))
  (format t "x-Inum times y-Rnum is ~a ~a~%" x y))

(setf *xi* (make-instance 'x-inum))
(setf *yi* (make-instance 'y-inum))
(setf *xr* (make-instance 'x-rnum))
(setf *yr* (make-instance 'y-rnum))


(multiply *xi* *yi*)
(multiply *xi* *yr*)

;;
;; Chapter 16: Object Reorientation: Generic Functions
;;

(comment "Chapter 16: Object Reorientation: Generic Functions")

;;
;;  Defgeneric and Defmethod (p.193-195)
;;
(defclass bnk-account ()
  (balance))

(defclass checking-account (bnk-account) ())
(defclass saving-account (bnk-account) ())
(defclass proxy-account () ())

(defgeneric withdraw (account amount)
  (:documentation "Withdraw the specified amount from the account.
Signal an error if the current balance is less than amount."))

(defmethod withdraw ((account bnk-account) amount)
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

(setf *ba* (make-instance 'bnk-account))
(setf *ca* (make-instance 'checking-account))
(setf *sa* (make-instance 'saving-account))
(setf *pa* (make-instance 'proxy-account))

(setf (slot-value *ba* 'balance) 1000)
(setf (slot-value *ca* 'balance) 100)
(setf (slot-value *sa* 'balance) 500)

;;
;; Method Combination
;; The Standard Method Combination
;;
(defclass ch16 ()
  ((id    :initarg :id    :accessor id)
   (var16 :initarg :var16 :accessor var16)))

(defclass ch16sct01 (ch16)
  ((sct01 :initarg :sct01 :accessor sct01)))

(defclass ch16sct02 (ch16)
  ((sct02 :initarg :sct02 :accessor sct02)))

(defgeneric ch16-hello (cls msg)
  (:documentation "**** Experiments ****"))

(defmethod ch16-hello ((cls ch16) msg)
  (format t "ch16-hello: Generic TopClass~%"))

(defmethod ch16-hello ((cls ch16sct01) msg)
  (format t "ch16-hello: ch16sct01~%")
  (call-next-method))

(defmethod ch16-hello :before  ((cls ch16) msg)
  (format t "ch16-hello: :before :GenericTop~%"))

(defmethod ch16-hello :after  ((cls ch16) msg)
  (format t "ch16-hello: :after :GenericTop~%"))

(defmethod ch16-hello :around  ((cls ch16) msg)
  (format t "ch16-hello: :around :GenericTop~%")
  (call-next-method))

(defgeneric print-obj (obj msg)
  (:documentation "print-obj():"))

(defmethod print-obj ((obj ch16) msg)
  (format t "print-obj: ~a~%" msg))
  
(setf *ch16* (make-instance 'ch16 :var16 16))
(setf *ch16sct01* (make-instance 'ch16sct01 :sct01 01))
(setf *ch16sct02* (make-instance 'ch16sct02 :sct02 02))

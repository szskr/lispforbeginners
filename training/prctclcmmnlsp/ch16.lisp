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
;;  Experiments
;;  The Standard Method Combination
;;
(defclass obj ()
  ((id :initarg :id :accessor id)))

(defclass book (obj)
  ((name  :initarg :name  :accessor name)))

(defclass chapter (book)
  ((id    :initarg :id    :accessor id)
   (chap  :initarg :chap  :accessor chap)))

(defclass section (chapter)
  ((sect :initarg :sect   :accessor sect)))

;;
;; Defgeneric and defmethods
;;

(defgeneric print-obj (obj msg)
  (:documentation "print-obj():"))

(defmethod print-obj (obj msg)
  (format t "(print-obj (obj msg): called. ~%"))

(defmethod print-obj ((obj obj) msg)
  (format t "print-obj((obj obj) msg): ~a~%" msg))

(defmethod print-obj ((obj chapter) msg)
  (format t "print-obj((obj ch16) msg): ~a~%" msg)) 

(defgeneric book-hello (cls msg)
  (:documentation "Studying Generic Function Mechanichary"))

(defmethod book-hello (cls msg)
  (format t "book-hello (cls msg):                 called~%"))

(defmethod book-hello ((cls book) msg)
  (format t "book-hello((cls book   ) msg):        called~%"))

(defmethod book-hello ((cls chapter) msg)
  (format t "book-hello((cls chapter) msg):        called~%")
  (call-next-method))

(defmethod book-hello ((cls section) msg)
  (format t "book-hello((cls section) msg):        called~%")
  (call-next-method))

(defmethod book-hello :before  ((cls book) msg)
  (format t "book-hello( cls book   ) msg): before called~%"))

(defmethod book-hello :after  ((cls book) msg)
  (format t "book-hello((cls book   ) msg): after  called~%"))

(defmethod book-hello :around  ((cls book) msg)
  (format t "book-hello((cls book   ) msg): around called~%")
  (call-next-method))


(defvar *obj* (make-instance 'obj :id "OBJ"))
(defvar *book* (make-instance 'book :name "Practical Common Lisp"))
(defvar *ch16* (make-instance 'chapter :chap 16))
(defvar *sct01* (make-instance 'section :sect 01))
(defvar *sct02* (make-instance 'section :sect 02))

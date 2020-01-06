;;;
;;; Practical: BookList
;;;

(nl)
(comment "Practical: BookList: book list db manager")
(nl)

(defvar *book-database* (make-hash-table :test #'equal))

(defclass book ()
  ((book-name   :initarg :bookname)
   (auther-name :initarg :author-name)
   (status      :initarg :status)))
   

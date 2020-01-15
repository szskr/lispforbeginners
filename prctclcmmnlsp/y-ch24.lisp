;;
;; Chapter 24: Practical: Parsing Binary Files
;;

(nl)
(comment "Y-Chapter 24: For Preparation of: Practical: Parsing Binary Files")
(nl)
	
;;
;; Binary Format Basics
;;

(format t "(ldb (byte 8 0) #xabcd) = 0x~x~%" (ldb (byte 8 0) #xabcd))
(format t "(ldb (byte 8 8) #xabcd) = 0x~x~%" (ldb (byte 8 8) #xabcd))
(format t "(ldb (byte 8 16) #x80efabcd) = 0x~x~%" (ldb (byte 8 16) #x80efabcd))
(format t "(ldb (byte 8 24) #x80efabcd) = 0x~x~%" (ldb (byte 8 24) #x80efabcd))

(defvar *num* 0)
(setf *num* 0)
(nl)

(format t "(defvar *num* 0) ~%")
(format t "0x~x~%" *num*)
(nl)

(format t "(setf (ldb (byte 8 0) *num*) #xcd) = 0x~x~%" (setf (ldb (byte 8 0) *num*) #xcd))
(format t "(setf (ldb (byte 8 8) *num*) #xab) = 0x~x~%" (setf (ldb (byte 8 8) *num*) #xab))
(format t "*num* = 0x~x~%" *num*)
(nl)

;;;
;;; Composite Structures
;;;
(comment "Composite Structure")
(defclass id-tag ()
  ((id    :initarg :id   :accessor id)
   (ver   :initarg :ver  :accessor ver)
   (size  :initarg :size :accessor size)))

(defvar *id1* (make-instance 'id-tag :id "id-1"   :ver 1 :size 100))
(defvar *id2* (make-instance 'id-tag :id "id-22"  :ver 2 :size 200))
(defvar *id3* (make-instance 'id-tag :id "id-333" :ver 3 :size 300))

(comment-out
 (defun read-id (in)
  (let (tag (make-instance 'id-tag))
    (with-slots (id ver size) tag
		(setf id (read-ascii-string in))
		(setf ver (read-num in))
		(setf size (read-num in))))))

(defun dump-id (id)
  (format t "dump_id: id = ~a, ver = ~a, size = ~a ~%" (id id) (ver id) (size id)))

;;;
;;; Designing the Macros
;;;
(comment "Desiging the Macros")

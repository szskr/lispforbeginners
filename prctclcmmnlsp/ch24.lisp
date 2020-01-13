;;
;; Chapter 24: Practical: Parsing Binary Files
;;

(nl)
(nl)
(chap24)
(comment "Chapter 24")
(nl)
	
;;
;; Binary Format Basics
;;

(defun read-u2-0 (in)
  (+ (* (read-byte in) 256) (read-byte in)))

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

(defun read-u2 (in)
  (let ((u2 0))
    (setf (ldb (byte 8 8) u2) (read-byte in))
    (setf (ldb (byte 8 0) u2) (read-byte in))
    u2))

(defun write-u2 (out value)
  (write-byte (ldb (byte 8 8) value) out)
  (write-byte (ldb (byte 8 0) value) out))

;;;
;;; Strings in Binary Files
;;;
(defconstant +null+ (code-char 0))

(defun read-null-terminated-ascii (in)
  (with-output-to-string (s)
			 (loop for char = (code-char (read-byte in))
			       until (char= char +null+) do (write-char char s))))

(defun write-null-terminated-ascii (string out)
  (loop for char across string
	do (write-byte (char-code char) out))
  (write-byte (char-code +null+) out))

(defun write-ascii-str (str fname)
    (let ((o (open-w-binary fname)))
      (write-null-terminated-ascii str o)
      (close o)))

;;;
;;; Composite Structures
;;;
(defclass id3-tag()
  ((identifier    :initarg :identifier    :accessor identifier)
   (major-version :initarg :major-version :accessor major-version)
   (revision      :initarg :revision      :accessor revision)
   (flags         :initarg :flags         :accessor flags)
   (size          :initarg :size          :accessor size)
   (frames        :initarg :frames        :accessor frames)))

(comment-out
 (defun read-id3-tag (in)
   (let ((tag (make-instance 'id3-tag)))
     (with-slots (identifier major-version revision flags size frames) tag
		(setf identifier    (read-iso-8859-1-string in :length 3))
		(setf major-version (read-u1 in))
		(setf revision      (read-u1 in))
		(setf flags         (read-u1 in))
		(setf size          (read-id3-encoded-size in))
		(setf frames        (read-id3-frames in :tag-size size)))
     tag)))

;;;
;;; Designing the Macros
;;;

;;
;; Write a macro so we can write stuff like the following.
;;   This is a handwritten vesion of define-binary-class.
;;
(comment-out
 (define-binary-class id3-tag
   ((file-identifier (iso-8859-1-string :length 3))
    (major-version u1)
    (revision      u1)
    (flags         u1)
    (size          id3-tag-size)
    (frames        (od3-frames :tag-size size)))))

;;;
;;; Making the Dream a Reality
;;;
(defun as-keyword (sym)
  (intern (string sym) :keyword))

(defun slot->defclass-slot (spec)
  (let ((name (first spec)))
    `(,name :initarg ,(as-keyword name) :accessor ,name)))

(defmacro define-binary-class (name slots)
  `(defclass ,name ()
     ,(mapcar #'slot->defclass-slot slots)))

(format t "macroexpand-1 
(macroexpand-1 '(define-binary-class id3-tag
		  ((identifier    (iso-8859-1-string :length 3))
		   (major-version u1)
		   (revision      u1)
		   (flags         u1)
		   (size          id3-tag-size)
		   (frames        (id3-frames :tag-size size))))) = ~%~a~%"
(macroexpand-1 '(define-binary-class id3-tag
		  ((identifier    (iso-8859-1-string :length 3))
		   (major-version u1)
		   (revision      u1)
		   (flags         u1)
		   (size          id3-tag-size)
		   (frames        (id3-frames :tag-size size))))))

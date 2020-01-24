;;
;; Chapter 24: Practical: Parsing Binary Files
;;

(nl)
(chap24)
(comment "Chapter 24: Practical: Parsing Binary Files")
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

(defparameter *num* 0)
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
(comment "Composite Structure")
(defclass id2-tag()
  ((identifier    :initarg :identifier    :accessor identifier)
   (major-version :initarg :major-version :accessor major-version)
   (revision      :initarg :revision      :accessor revision)
   (flags         :initarg :flags         :accessor flags)
   (size          :initarg :size          :accessor size)
   (frames        :initarg :frames        :accessor frames)))

(comment-out
 (defun read-id2-tag (in)
   (let ((tag (make-instance 'id2-tag)))
     (with-slots (identifier major-version revision flags size frames) tag
		(setf identifier    (read-iso-8859-1-string in :length 3))
		(setf major-version (read-u1 in))
		(setf revision      (read-u1 in))
		(setf flags         (read-u1 in))
		(setf size          (read-id3-tag-size in))
		(setf frames        (read-id3-frames in :tag-size size)))
     tag)))

;;;
;;; Designing the Macros
;;;
(comment "Desiging the Macros")

;;
;; Write a macro so we can write stuff like the following.
;;   This is a handwritten vesion of define-binary-class.
;;
(comment-out
 (define-binary-class id2-tag
   ((file-identifier (iso-8859-1-string :length 3))
    (major-version u1)
    (revision      u1)
    (flags         u1)
    (size          id2-tag-size)
    (frames        (id2-frames :tag-size size)))))

;;;
;;; Making the Dream a Reality
;;;
(comment "Making the Dream a Reality")

(defun as-keyword (sym)
  (intern (string sym) :keyword))

(defun slot->defclass-slot (spec)
  (let ((name (first spec)))
    `(,name :initarg ,(as-keyword name) :accessor ,name)))

(defmacro define-binary-class-v0 (name slots)
  `(defclass ,name ()
     ,(mapcar #'slot->defclass-slot slots)))

(format t "macroexpand-1 
(macroexpand-1 '(define-binary-class-v0 id2-tag
		  ((identifier    (iso-8859-1-string :length 3))
		   (major-version u1)
		   (revision      u1)
		   (flags         u1)
		   (size          id2-tag-size)
		   (frames        (id2-frames :tag-size size))))) = ~%~a~%"
(macroexpand-1 '(define-binary-class-v0 id2-tag
		  ((identifier    (iso-8859-1-string :length 3))
		   (major-version u1)
		   (revision      u1)
		   (flags         u1)
		   (size          id2-tag-size)
		   (frames        (id2-frames :tag-size size))))))
(nl)

;;;
;;; Reading Binary Objects
;;;
(comment "Reading Binary Objects")

(defgeneric read-value (type stream &key)
  (:documentation "Read a value of the given type from the stream."))

(comment "The following 4 read-value methods are stub methods for now.")

(defmethod read-value ((type (eql 'iso-8859-1-string)) in &key length)
  (format t "(read-value 'iso-8859-1-string) called. in = ~a ~%" in)
  "IS3")

(defmethod read-value ((type (eql 'u1)) in &key)
  (format t "(read-value 'u1) called. in = ~a ~%" in)
  #xab)

(defmethod read-value ((type (eql 'id3-tag-size)) in &key)
  (format t "(read-value 'id3-encoded-size) called. in = ~a ~%" in)
  #x10)

(defmethod read-value ((type (eql 'id3-frames)) in &key tag-size)
  (format t "(read-value 'id3-frames) called.~%")
  #x11)

(defmethod read-value ((type (eql 'id4-tag-size)) in &key)
  (format t "(read-value 'id4-encoded-size) called.~%")
  #x10)

(defmethod read-value ((type (eql 'id4-frames)) in &key tag-size)
  (format t "(read-value 'id4-frames) called.~%")
  #x11)

(defmethod read-value ((type (eql 'id3-tag)) in &key)
  (let ((object (make-instance 'id3-tag)))
    (with-slots (identifier major-version revision flags size frames) object
		(setf identifier    (read-value 'iso-8859-1-string in :length 3))
		(setf major-version (read-value 'u1 in))
		(setf flags         (read-value 'u1 in))
		(setf size          (read-value 'id3-tag-size in))
		(setf frames        (read-value 'id3-frames in :tag-size size)))
    object))

(defun slot->read-value (spec stream)
  (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec)
    `(setf ,name (read-value ',type ,stream ,@args))))

(defun normalize-slot-spec (spec)
  (list (first spec) (mklist (second spec))))

(defun mklist (x)
  (if (listp x)
      x
    (list x)))

(defmacro define-binary-class-v1 (name slots)
  (with-gensyms-1 (typevar objectvar streamvar)
		`(progn
		   (defclass ,name ()
		     ,(mapcar #'slot->defclass-slot slots))
		   
		   (defmethod read-value ((,typevar (eql ',name)) ,streamvar &key)
		     (let ((,objectvar (make-instance ',name)))
		       (with-slots ,(mapcar #'first slots) ,objectvar
				   ,@(mapcar #'(lambda (x) (slot->read-value x streamvar)) slots))
		       ,objectvar)))))

(define-binary-class-v1 id4-tag
		  ((identifier    (iso-8859-1-string :length 3))
		   (major-version u1)
		   (revision      u1)
		   (flags         u1)
		   (size          id4-tag-size)
		   (frames        (id4-frames :tag-size size))))

(defvar *id4-tag* (make-instance 'id4-tag))
(nl)

(format t "(read-value 'id4-tag 10) = ~%~a" (read-value 'id4-tag 10))
(nl)

(format t "defvar *i* (read-value 'id4-tag 100) = ~%~a~%" (defvar *i* (read-value 'id4-tag 100)))

;;;
;;; Writing Binary Objects
;;;
(comment "Writing Binary Objects")

(defgeneric write-value (type stream value &key)
  (:documentation "Write a value as athe given type to the stream."))

(defun slot-write-value (spec stream)
  (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec)
		      `(write-value ',type ,name ,@args)))

;;;
;;; Adding Inheritance3 and Tagged Structures
;;;
(comment "Adding Inheritance and Tagged Structures")

(defgeneric read-object (object stream)
  (:method-combination progn :most-specific-last)
  (:documentation "Fill in the slots of objects from stream."))

(defmethod read-value ((type symbol) stream &key)
  (format t "DEBUG: (read-value ((type symbol) stream &key~%")
  (let ((object (make-instance type)))
    (read-object object stream)
    object))

(defmethod read-value ((type (eql 'string)) in &key length)
  (format t "(read-value ((type (eql 'string)) in &key lengh) called. in = ~a length = ~a~%" in length)
  "Hello World")

(defmacro define-binary-class-v2 (name superclasses slots)
  (with-gensyms-1 (objectvar streamvar)
		  `(progn
		   (defclass ,name ,superclasses
		     ,(mapcar #'slot->defclass-slot slots))
		   
		   (defmethod read-object progn ((,objectvar ,name) ,streamvar)
		       (with-slots ,(mapcar #'first slots) ,objectvar
				   ,@(mapcar #'(lambda (x) (slot->read-value x streamvar)) slots))))))

(define-binary-class-v2 id10-tag (id4-tag) 
		  ((my-id       (string :length 3))
		   (id10-var1    u1)
		   (ir10-var2    u1)))
(comment "Allocating and setting id10-tag instance")

(defparameter *id10-tag* (read-value 'id10-tag 1000))

;;;
;;; Keeping Track of Inherited Slots
;;;
(comment "Keeping Track of Inherited Slots")

(defmethod read-value ((type (eql 'u3)) in &key)
  (format t "(read-value 'u3) called. in = ~a ~%" in)
  #xabcdef)

(defmethod read-value ((type (eql 'raw-bytes)) in &key bytes)
  (format t "(read-value 'raw-bytes) called. in = ~a ~%" in)
  #xaabb)

(define-binary-class-v2 generic-frame-0 ()
  ((id (string :length 3))
   (size u3)
   (data (raw-bytes :bytes size))))

(defvar  *generic-frame* (read-value 'generic-frame-0 "HelloWorld"))

;;;
;;; The next two definitions do not work as expected.
;;;   The slot 'size' in generic-frame become undefined.
;;;

(define-binary-class-v2 frame ()
  ((id (string :length 3))
   (size u3)))

(comment-out
 (define-binary-class-v2 generic-frame (frame)
  ((data (raw-bytes :bytes size)))))

;;;
;;; Fixing the problem
;;;

;;;
;;; Helper Functions
;;;

;;;
;;; REVIEW loop + nconc verb
;;;

(defun ch23-loop-nconc()
  (loop for i upto 3
      nconc (list i i)
      nconc (list (* 10 i) (* 10 i))
      nconc (list (* 100 i) (* 100 i))))


(defun direct-slots (name)
  (copy-list (get name 'slots)))

(defun inherited-slots (name)
  (loop for super in (get name 'superclasses)
	nconc (direct-slots super)
	nconc (inherited-slots super)))

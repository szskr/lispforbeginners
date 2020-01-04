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
  (write-byte (ldb (8 8) value) out)
  (write-byte (ldb (8 0) value) out))

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
  


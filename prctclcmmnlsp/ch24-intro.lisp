;;
;; Chapter 24: Intro. To: Practical: Parsing Binary Files
;;

(nl)
(nl)
(chap24-intro)
(comment "Chapter 24: Introduction")
(nl)

;;
;; Review: opening a file to read binary data
;;
(defun open-r-binary (name)
  (open name
	:if-does-not-exist nil
	:element-type '(unsigned-byte 8)))

(defun open-w-binary (name)
  (open name
	:if-does-not-exist :create
	:if-exists :append
	:direction :output
	:element-type '(unsigned-byte 8)))

(defun cat (file)
  ())

(defun cp (src dst)
  (let ((in (open-r-binary src))
	(out (open-w-binary dst))
	(byte 0))
    (when (eq in nil)
      (format t "cp: ~a can not be open~%" src)
      (return-from cp nil))
    (when (eq out nil)
      (format t "cp: ~a can not be open~%" dst)
      (close in)
      (return-from cp nil))
    (setf byte (read-byte in))
    (write-byte byte out)
    (close in)
    (close out)))
	

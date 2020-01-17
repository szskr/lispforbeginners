;;
;; Chapter 24: Intro. To: Practical: Parsing Binary Files
;;

(nl)
(nl)
(appendx-chap24)
(comment "Appendix: Supplementary for Chapter 24")
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
  (let ((in (open-r-binary file))
	(byte 0))
    (when (eq in nil)
      (format t "cat: ~a can not be open~%" file)
      (return-from cat nil))
    (loop
     (setf byte (read-byte in nil))
     (format t "0x~x~%" byte)
     (when (eq byte nil)
       (return)
    (close in)))))

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
    (loop
     (setf byte (read-byte in nil))
     (if (not (eq byte nil))	 
	 (write-byte byte out))
     (when (eq byte nil)
       (return)))
    (close in)
    (close out)))

;;
;; Using with-open-file function
;;
(defun byte-copy (src dst)
  (with-open-file (in src
		      :direction :input
		      :element-type '(unsigned-byte 8)
		      :if-does-not-exist nil)
		  (when in
		    (with-open-file (out dst
					 :direction :output
					 :element-type '(unsigned-byte 8)
					 :if-exists :supersede)
				    (loop for byte = (read-byte in nil)
					  while byte
					  do (write-byte byte out))))))

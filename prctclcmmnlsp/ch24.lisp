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
(defun read-u2 (in)
  (+ (* (read-byte in) 256) (read-byte in)))

(format t "(ldb (byte 8 0) #xabcd) = 0x~x~%" (ldb (byte 8 0) #xabcd))
(format t "(ldb (byte 8 8) #xabcd) = 0x~x~%" (ldb (byte 8 8) #xabcd))
(nl)

;;
;; Chapter 14: FILES and FILE I/O
;;

(nl)
(chap14)
(comment "Chapter 14")

;;;
;;; Reading File Data
;;;
(defvar ch14.01.txt "./ch14.01.txt") ;; Regular text file
(defvar ch14.02.txt "./ch14.02.txt") ;; S-expressions
(defvar ch14.03.txt "./ch14.03.txt") ;; Output file

(nl)
(comment "Opening a text file1:")
(format t "(setf fin1 (open ch14.01.txt)) = ~a~%" (setf fin1 (open ch14.01.txt)))
fin1

(nl)
(comment "Opening a text file2:")
(format t "(setf fin2 (open ch14.02.txt)) = ~a~%" (setf fin2 (open ch14.02.txt)))
fin2

(nl)
(format t "Read a text line from ~a~%" ch14.01.txt)
(let ((in (open ch14.01.txt)))
  (format t "~a ~%" (read-line in))
  (close in))

(nl)
(format t "Read all text lines from ~a~%" ch14.01.txt)
(let ((in (open ch14.01.txt :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	  while line do (format t "~a~%" line))
    (close in)))
(nl)

(nl)
(format t "Read all S-expressions from ~a~%" ch14.02.txt)
(let ((in (open ch14.02.txt :if-does-not-exist nil)))
  (when in
    (loop for line = (read in nil)
	  while line do (format t "~a~%" line))
    (close in)))
(nl)

;;;
;;; Reading Binary Data
;;; 
(nl)
(comment "Opening a binary file:")
(format t "(setf fin3 (open ch14.01.txt) :element-type '(unsigned-byte 8)) = ~a~%"
	(setf fin3 (open ch14.01.txt :element-type '(unsigned-byte 8))))
fin3

(nl)
(format t "Read a byte from ~a~%" ch14.01.txt)
(let ((in (open ch14.01.txt :element-type '(unsigned-byte 8))))
  (format t "0x~x ~%" (read-byte in))
  (close in))

;;;
;;; File Output
;;;
(nl)
(comment "Going to wrint into a file")
(format t "Going to write a string into ~a~%" ch14.03.txt)
(let ((out (open ch14.03.txt :direction :output :if-exists :supersede)))
  (write-line "Hello World" out)
  (close out))

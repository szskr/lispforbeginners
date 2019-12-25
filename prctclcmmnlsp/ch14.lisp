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

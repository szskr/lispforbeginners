;;
;; Chapter 14: FILES and FILE I/O
;;

(nl)
(chap14)
(comment "Chapter 14")

;;;
;;; Reading File Data
;;;
(defvar ch14.01.txt "./ch14.01.txt")

(nl)
(comment "Opening a text file:")
(format t "(setf fin (open ch14.01.txt)) = ~a~%" (setf fin (open ch14.01.txt)))
fin

(nl)
(format t "Read a text line from ~a~%" fin)
(let ((in (open ch14.01.txt)))
  (format t "~a ~%" (read-line in))
  (close in))

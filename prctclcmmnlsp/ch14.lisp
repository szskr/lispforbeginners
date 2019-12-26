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
(defvar ch14.04.txt "./ch14.04.txt") ;; Output file

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

;;;
;;; Closing Files
;;;
(nl)
(comment "Open/Write/Close with with-open-file() macro")
(with-open-file (stream ch14.04.txt :direction :output :if-exists :supersede)
		(write-line "Hello World No.02" stream)
	       	(write-line "Hello World No.03" stream))

;;;
;;; Filename <-> Pathname
;;;  namestrings - file name strings used in the local system. EX: "./work/ch14.lisp" "/usr/szskr/workspaces/"
;;;  pathname object - namestring translated by PATHNAME function
;;;                    (EX) (setf pobj (pathname "./work/ch14.lisp"))
;;;  The function namestring translates pathname object back to original string
;;;

(nl)
(comment "FILENAMES- namestring, pathname, namestring->pathname, pathname->namestring")
(setf raw-string-name "/lisp/prlisp/ch14.lisp")

(nl)
(format t "raw-string-name = ~a~%" raw-string-name)
(format t "(pathname raw-string-name) = ~a~%" (pathname raw-string-name))
(setf path-name (pathname raw-string-name))

(format t "(pathname-directory path-name)=~a~%" (pathname-directory path-name))
(format t "(pathname-name path-name)=~a~%" (pathname-name path-name))
(format t "(pathname-type path-name)=~a~%" (pathname-type path-name))
(nl)
(format t "(namestring path-name)=~a~%" (namestring path-name))
(format t "(directory-namestring path-name)=~a~%" (directory-namestring path-name))
(format t "(file-namestring path-name)=~a~%" (file-namestring path-name))
(nl)

;;;
;;; Constructing New Pathnames
;;;
(nl)
(setq pathname-created (make-pathname
 :directory '(:absolute "foo" "bar" "hoo")
 :name "baz"
 :type "txt"))

(format t "pathname-created = ~a~%" pathname-created)
(format t "(make-pathname :name \"foo\" :type \"txt\") = ~a~%" (make-pathname :name "foo" :type "txt"))
(nl)

(setf ROOT-dir "/usr/src/")
(setf REL-dir "cmd/sgs/")
(setf merged-pathname (merge-pathnames (pathname REL-dir) (pathname ROOT-dir)))
(format t "(merge-pathnames (pathname \"~a\") (pathname \"~a\")) = #p\"~a\"~%" REL-dir ROOT-dir merged-pathname)

;;;
;;; Interacting with the File System
;;;

(setf delete-me "_DELETE_ME_")

(defun create-file (name)
  (close (open name :if-does-not-exist :create)))

(format t "~a~%" (create-file delete-me))
(format t "(probe-file delete-me) = ~a~%" (probe-file delete-me))
(format t "(delete-file delete-me) = ~a~%" (delete-file delete-me))
(format t "(probe-file delete-me) = ~a~%" (probe-file delete-me))

(nl)

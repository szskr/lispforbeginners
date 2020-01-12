;;;
;;; Word List Manager
;;;

(comment "Loading wordlist.lisp")
(nl)

;;;
;;; Classes
;;;

(defclass root ()
  ((root
    :initarg :root
    :initform (error "Must provide ROOT")
    :accessor root)
   (r-type       ;; (word == :prefix :root :suffix)
    :initarg :r-type
    :accessor r-type)
   (def
    :initarg :def
    :accessor def)
   (wds
    :initarg :wds
    :accessor wds)))

(defclass a-word ()
  ((wd
    :initarg :wd
    :initform (error "Must provide WD- WORD")
    :accessor wd)
   (def
    :initarg :def
    :accessor def)
   (examples
    :initarg :examples
    :accessor examples)))

;;;
;;; Generic functions and methods
;;;

(defgeneric print-root (root)
  (:documentation "print out dictinary-like root information."))

(defgeneric print-word (word)
  (:documentation "print a word"))


(defmethod print-root ((rt root))
  (with-accessors ((root root)
		   (r-type r-type)
		   (def def)
		   (wds wds)) rt
		   (format t "print-root: called. ~a~%" rt)
		   (format t " root = ~a~%" root)
		   (format t " type = ~a~%" r-type)
		   (format t " def  = ~a~%" def)))

(defmethod print-word ((wd a-word))
  (format t "print-word: called. ~a~%" wd))

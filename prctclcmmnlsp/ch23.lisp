;;
;; Chapter 23: Practical: A Spam Filter
;;

(nl)
(nl)
(chap23)
(comment "Chapter 23")
(nl)

;;
;; The Heart of a Spam Filter
;;
(comment "Package related codes are ignored for now")

;(defpackage :spam
;  (:use :common-lisp)
;  (:export :classify))

;(in-package :spam)

(defun classify (text)
  (classification (score (extract-features text))))

;;;
;;; Non-spam, known as HAM
;;;
(defparameter *max-ham-score* 0.4)
(defparameter *min-spam-score* 0.6)
(defvar *feature-database* (make-hash-table :test #'equal))

(defun classification (score)
  (cond
   ((<= score *max-ham-score*) 'ham)
   ((>= *min-spam-score*) 'spam)
   (t 'unsure)))

;;;
;;; Changed word to pclword. (Probably name crashing. Fix later.)
;;;
(defclass word-feature ()
  ((pclword
    :initarg :pclword
    :accessor pclword
    :initform (error "Must supply :pclword")
    :documentation "The word this feature represents.")
   (spam-count
    :initarg :spam-count
    :accessor spam-count
    :initform 0
    :documentation "Number of spams we have seen this feaure in")
   (ham-count
    :initarg :ham-count
    :accessor ham-count
    :initform 0
    :documentation "Number of hams we have seen this feature in.")))

(defun clear-database ()
  (setf *feature-database*  (make-hash-table :test #'equal)))

(defun intern-feature (word)
  (or (gethash word *feature-database*)
      (setf (gethash word *feature-database*)
	    (make-instance 'word-feature :word word))))

;;;
;;; FIX_ME!
;;;
(setf *l-ppcre-loaded* nil)
(when (not *l-ppcre-loaded*)
  (comment "Let's load CL-PPCRE")
  (setf *l-ppcre-loaded* t)
  (l-ppcre))
;;;
;;;
;;;

(defun extract-words (text)
  (delete-duplicates
   (cl-ppcre:all-matches-as-strings "[a-zA-Z]{3,}" text)
   :test #'string=))

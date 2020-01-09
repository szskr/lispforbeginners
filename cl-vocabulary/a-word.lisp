;;;
;;; Vocabulary Builder
;;;

(comment "Loading A-word.lisp")
(nl)

(defclass root ()
  ((root
    :initarg :root)
   (def
     :initarg :def)
   (wds
    :initarg :wds)))

(defgeneric print-root (root)
  (:documentation "print out dictinary-like root information."))

(defclass a-word ()
  ((wd
    :initarg :wd
    :initform nil)
   (def
     :initarg :def)
   (exs
    :initarg :exs)
   (root
    :initarg :root)
   (cmmts
    :initarg :comments)))

(defgeneric print-word (wd)
  (:documentation "print out dictinary-like word information."))

;;;
;;;
;;;
(defparameter *w1*
  (make-instance 'a-word
		 :wd "Tokyo"
		 :exs '("Tokyo is the capital of Japan."
			"2020 Olympic will be held in Tokyo")))
(defparameter *w2*
  (make-instance 'a-word
		 :wd "Sapporo"
		 :exs '("Sapporo is the biggest city in Hokkaido."
			"2022 Winter Olympic will be held in Sapporo?")))

;;;
;;; slot-value
;;;
(format t "(slot-value *w1* 'wd) = ~a~%" (slot-value *w1* 'wd))
(format t "(slot-value *w1* 'exs) = ~a~%" (slot-value *w1* 'exs))
(comment "Adding an example sentence")
(setf (slot-value *w1* 'exs) (append (slot-value *w1* 'exs) '("1964 Olympic was held in Tokyo too")))
(format t "(slot-value *w1* 'exs) = ~a~%" (slot-value *w1* 'exs))

;;;
;;; setf function
;;;
(defparameter *w3* (make-instance 'a-word))

(defgeneric (setf wd) (value a-word))

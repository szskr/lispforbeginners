;;;
;;; Vocabulary Builder
;;;

(comment "Loading A-word.lisp")
(nl)

(defclass root ()
  ((root
    :initarg :root)
   (definition
     :initarg :definition)
   (words
    :initarg :words)))

(defclass a-word ()
  ((a-word
    :initarg :a-word)
   (definition
     :initarg :definition)
   (examples
    :initarg :examples)
   (root
    :initarg :root)
   (comments
    :initarg :comments)))

;;;
;;;
;;;
(defparameter *w1*
  (make-instance 'a-word
		 :a-word "Tokyo"
		 :examples '("Tokyo is the capital of Japan."
			     "2020 Olympic will be held in Tokyo")))
(defparameter *w2*
  (make-instance 'a-word
		 :a-word "Sapporo"
		 :examples '("Sapporo is the biggest city in Hokkaido."
			     "2022 Winter Olympic will be held in Sapporo?")))

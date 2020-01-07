;;;
;;; Vocabulary Builder
;;;

(defclass a-word ()
  ((a-word
    :initarg :a-word)
   (root
    :initarg :root)
   (definition
     :initarg :definition)
   (examples
    :initarg :examples)
   (comments
    :initarg :comments)))

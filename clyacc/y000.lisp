;;;
;;; Prerequisites
;;;

(deftype index () '(unsigned-byte 14))
(deftype signed-index () '(signed-byte 15))

(defstruct person
  name
  age
  hobbies)


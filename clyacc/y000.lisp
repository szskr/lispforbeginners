;;;
;;; Prerequisites
;;;

(defun lm () (load "./y000.lisp"))
  
(deftype index () '(unsigned-byte 14))
(deftype signed-index () '(signed-byte 15))

;;
;; function arguments
;;   &optional
;;   &rest
;;   &key
;;
(defun foo_opt (a b &optional (c 100) (d 200))
  (format t "a = ~a, b = ~a, c = ~a, d = ~a" a b c d))

(defun foo_rest (a &rest values)
  (format t "a = ~a values = ~a" a values))

(defun foo_key (&key a b c d)
  (format t "a = ~a b= ~a  c = ~a d = ~a" a b c d))

(defun foo_key_def (&key (a 10) b (c 100) d)
  (format t "a = ~a b= ~a  c = ~a d = ~a" a b c d))

;;
;; On Structure
;;

(defstruct person00
  name
  age
  hobbies)

(defstruct (person01)
  (name)
  age
  hobbies)

(setq *KenT* (make-person00 :name "Ken Thompson" :age 67 :hobbies '(programming unix)))
(setq *Dennis* (make-person01 :name "Dennis Richie" :age 100 :hobbies '(programming C)))

;;;
;;; Option :constructor
;;;
;;; This option takes one argument, a symbol, which specifies the name of the constructor
;;; function. If the argument is not provided or if the option itself is not provided,
;;; the name of the constructor is produced by concatenating the string "MAKE-" and the name
;;; of the structure, putting the name in whatever package is current at the time the
;;; defstruct form is processed (see *package*). If the argument is provided and is nil,
;;; no constructor function is defined.
;;;
(defstruct (person10)
  name
  age
  hobbies)

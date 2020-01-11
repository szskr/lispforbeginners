;;;
;;; Vocabulary Builder
;;;

(comment "Loading A-word.lisp")
(nl)

(defclass root ()
  ((root
    :initarg :root
    :initform (error "Must provide ROOT")
    :accessor root)
   (def
    :initarg :def
    :accessor def)
   (wds
    :initarg :wds)))

(defgeneric print-root (root)
  (:documentation "print out dictinary-like root information."))

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


(defgeneric print-word (wd)
  (:documentation "print out dictinary-like word information."))

;;;
;;;
;;;
(defparameter *r-u01-01*
  (make-instance 'root
		 :root "BENE"
		 :def '("BENE is Latin for 'well'."
		       "A Benefit is a good result or effect."
		       "Something beneficial produes good results or effects.")))

(defparameter *r-u01-02*
  (make-instance 'root
		 :root "AM"
		 :def '("AM comes from the Latin 'amare'."
		       "The Roman god of love was known by two differnt names, Cupid and Amor."
		       "Amiable means 'friendly or good-natured' and amigo is Spanish for 'friend.")))


(defparameter *w-u01-01
  (make-instance 'a-word
		 :wd "benediction"
		 :def '("A prayer that asks for God's blessing, especially a prayer that concludes a worship service.")
		 :examples '("The moment the bishop had finishied his benediction, she squeezed quickly out of her row and darted out the cathedral's side entrance")))

(defparameter *w-u01-02*
  (make-instance 'a-word
		 :wd "benefactor"
		 :def '("Someone who helps another person or group, especially by giving money.")
		 :examples '("An anonymous benefactor had given $15 million to establish an ecological institution at the university.")))

(defparameter *w-u02-01
  (make-instance 'a-word
		 :wd "amicable"
		 :def '("Friendly, peaceful")
		 :examples '("Their relations with their in-laws were generally amicable, sespite some bickering during the holidays.")))

(defparameter *w-u02-02
  (make-instance 'a-word
		 :wd "enamored"
		 :def '("Charmed or fascinatedl inflamed with love.")
		 :examples '("Rebecca quickly became enamoured of the town's rustic surroundings, its slow pace, and its eccentric characters.")))


;;;
;;; slot-value
;;;
(comment-out
 ((format t "(slot-value *w1* 'wd) = ~a~%" (slot-value *w1* 'wd))
 (format t "(slot-value *w1* 'examples) = ~a~%" (slot-value *w1* 'examples))
 (comment "Adding an example sentence")
 (setf (slot-value *w1* 'examples) (append (slot-value *w1* 'examples) '("1964 Olympic was held in Tokyo too")))
 (format t "(slot-value *w1* 'examples) = ~a~%" (slot-value *w1* 'examples))))

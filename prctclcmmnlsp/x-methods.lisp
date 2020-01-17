;;;
;;; From Lispcookbook.ghthub.io/cl-cookbook/clos.html
;;;

(comment "LispCookBook: Mthods - Diving in")
(nl)

(fmakunbound 'greet)

(defclass person ()
  ((name
    :initarg :name
    :accessor name)))

(defclass child (person)
  ())

(setf p1 (make-instance 'person :name "me"))
(setf c1 (make-instance 'child :name "Alice"))

(defmethod greet (obj)
  (format t "Are you a person ? You are a ~a.~&" (type-of obj)))

(greet :anything)

(defgeneric greet (obj)
  (:documentation "say hello"))

(defmethod greet ((obj person))
  (format t "Hello ~a !~&" (name obj)))

(defmethod greet ((obj child))
  (format t "Ur so cute !~&"))

(greet p1)
(greet c1)

;;;
;;; Method combination: before, after, around
;;;
(nl)
(comment "Method combination: before, after, around")
(nl)

(defmethod greet :before ((obj person))
  (format t "-- before person~&"))

(greet p1)
(nl)

(defmethod greet :before ((obj child))
  (format t "-- before child~&"))
(greet c1)
(nl)

(defmethod greet :after ((obj person))
  (format t "-- after person~&"))

(defmethod greet :after ((obj child))
  (format t "-- after child~&"))

(greet p1)
(nl)

(greet c1)

;;;
;;; Adding in &key
;;;

;;
;; Unbound greet
;;
(fmakunbound 'greet)

(defmethod greet ((obj person) &key talkative)
  (format t "Hello ~a~&" (name obj))
  (when talkative
    (format t "blah~%")))

(greet p1)
(nl)

(greet p1 :talkative t)
(nl)

(greet p1 :talkative nil)


(defgeneric greet (obj &key &allow-other-keys)
  (:documentation "say hi"))

(defmethod greet (obj &key &allow-other-keys)
  (format t "Are you a person ? You are a ~a.~&" (type-of obj)))

(defmethod greet ((obj person) &key talkative &allow-other-keys)
  (format t "Hello ~a !~&" (name obj))
  (when talkative
    (format t "blah~%")))

(greet p1 :talkative t) ;; ok
(nl)

(greet p1 :foo t) ;; still ok
(nl)

(greet 100)

;;
;;
;;

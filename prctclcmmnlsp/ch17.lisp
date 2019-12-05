;;
;; Chapter 16: Object Reorientation: Generic Functions
;; Chapter 17: Object Reorientation: Classes
;;

;;
;; Notes
;;

;;
;; A generic function is generic in the sense that it can accept any objectsas arguments.
;; However, a generic function can't actuallt do anything.
;;  The actual implementation has to be provided by METHODS. Each method provides provides an
;;  implementation of the generic function for the particular claees of arguments.
;;  Methods DO NOT belong to the clsses. They belong to the generic function!
;;
;; Methods indicatee what kinds of arguments they can handle by SPECIALIZING the rquired
;; parameters defined by the generic function.
;;
;;   (defgeneric draw (shape)
;;     (:documentation "Draw the given shape on the screen"))
;;
;;   (defmethod draw ((shape circle))
;;     (format t "Draw Circle"))
;;
;;   (defmethod draw ((shape triangle))
;;     (format t "Draw TRIANGLE.."))
;;
;;   CIRCLE and TRIANGLE are classes.
;;

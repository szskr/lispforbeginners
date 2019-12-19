;;
;; Chapter 06: Variables
;;

(nl)
(nl)
(chap06)
(comment "Chapter 06")
(nl)

;;;
;;; Closure
;;;
(defparameter *counter*
  (let ((count 0))
    #'(lambda () (setf count (1+ count)))))

(defmacro counter ()   ;; CLOSURE
  `(funcall *counter*))

(defun cn ()           ;; Not CLOSURE    THINK ABOUT it!
  (let ((cntr 0)) (setf cntr (1+ cntr))))


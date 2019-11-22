;;
;; Chapter 05: Variables
;;


(defparameter *fn5-1* (let ((count 0)) #'(lambda () (setf count (+ 1 count))))) ;; Closure!

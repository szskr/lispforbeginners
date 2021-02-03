;;
;; loops: do, loop, etc
;;

;;
;; (dolist (var list-form)
;;   body-form)
;;

(dolist (x '(1 2 3))
  (print x))

(dolist (x '(1 2 3 4))
  (print x)
  (if (evenp x)
      (return)))

(defun do-list()
  (dolist (x '(1 2 3))
    (print x)))
  

;;
;; (dotimes *var count-form)
;;   body-form)
;;
(dotimes (i 4) (print i))

(defun d-10()
  (dotimes (x 10)
    (dotimes (y 10)
      (format t "~3d " (* (+ 1 x) (+ 1 y))))
    (format t "~%")))

;;
;; (do (variable-definitions*)
;;     (end-test-form result-forms*)
;;   statements*)
;;


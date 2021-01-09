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

;;
;; 


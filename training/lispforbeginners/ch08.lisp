;;
;; Chapter 04
;;

(setq one (cons 'one 1))
(setq two (cons 'two 2))
(setq three (cons 'three 3))
(setq L (list one two three))

(assoc 'two L)

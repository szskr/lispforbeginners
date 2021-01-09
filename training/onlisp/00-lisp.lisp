;;;
;;; Misc features
;;;

;;
;; mappings
;;
(setq v1 (vector 1 2 3))
(setq v2 (vector 100 200 300))

;; map
(setq mv (map 'vector #'* v1 v2))
mv

;; mapcar
(setq ml (mapcar #'+ '(1 2 3) '(100 200 300)))

;;
;; Special Operators
;;

;;
;; Multiple values
;;   Returning multiple values
;;   Receiving multiple values
;;
;;   Returning multiple values
;;     Use the functions value and values-list

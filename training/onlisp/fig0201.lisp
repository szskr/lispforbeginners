;;
;; Fig 02.01
;;
(defun make-dbms (db)
  (list
   #'(lambda (key)
       (cdr (assoc key db)))
   #'(lambda (key val)
       (push (cons key val) db)
       key)
   #'(lambda (key)
       (setf db (delete key db :key #'car))
       key)))

;;
;; supplementary function
;;
(defun lookup (key db)
  (funcall (car db) key))

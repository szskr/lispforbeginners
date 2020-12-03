

(defun t-rep ()
  (prog (s env)
	loop
	(setq s (read))
	(cond ((atom s) (w
	(write s)
	(go loop)))


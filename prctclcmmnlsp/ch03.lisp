;;
;; Chapter 03: Practical: A Simple Database
;;

(defvar *db* nil)

(defun make-cd (title artist rating ripped)
  (list :title title :artist artist rating rating :ripped ripped))

(defun add-record(cd) (push cd *db*))

(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))

(defun prompt-read0 (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped [y/n]")))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
	(if (not (y-or-n-p "Anoter? [y/n]: ")) (return))))

(defun save-db (filename)
  (with-open-file (out filename
		       :direction :output
		       :if-exists :supersede)
		  (with-standard-io-syntax
		   (print *db* out))))

(defun load-db (filename)
  (with-open-file (in filename)
		  (with-standard-io-syntax
		   (setf *db* (read in)))))
  
(defun remove-odd (l)
  (remove-if-not #'evenp l))

(defun remove-odd2 (l)
  (remove-if-not #'(lambda (x) (= 0 (mod x 2))) l))

(defun select-by-artist (artist)
  (remove-if-not
   #'(lambda (cd)
       (equal (getf cd :artist) artist))
   *db*))

(defun select (selector-fn)
  (remove-if-not selector-fn *db*))

(defun foo (&key a b c) (list a b c))

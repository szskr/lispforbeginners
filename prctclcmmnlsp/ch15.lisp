;;
;; Chapter 15: Practical: A Portable Pathname Library
;;

(nl)
(chap15)
(comment "Chapter 15")

;;;
;;; *FEATURES* and Read-Time Conditionalization
;;;
*features*
(format t "*features* = ~a~%" *features*)
(nl)

(setf home-dir-str "/Users/KenThompson")
(format t "home-dir-str = \"~a\"~%" home-dir-str)

(setf home-dir-path (pathname home-dir-str))
(format t "(directory (make-pathname :name :wild :type :wild :defaults home-dir-path)) = ~a~%"
	(directory (make-pathname :name :wild :type :wild :defaults home-dir-path)))
(nl)

;;;
;;; OK, let's work on it
;;;
(defun component-present-p (value)
  (and value (not (eql value :unspecific))))

(defun directory-pathname-p (p)
  (and
   (not (component-present-p (pathname-name p)))
   (not (component-present-p (pathname-type p)))
   p))

(defun pathname-as-directory (name)
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't reliablu convert wild pathnames."))
    (if (not (directory-pathname-p name))
	(make-pathname
	 :directory (append (or (pathname-directory pathname) (list :relative))
			    (list (file-namestring pathname)))
	 :name nil
	 :type nil
	 :defaults pathname)
      pathname)))

(defun directory-wildcard (dirname)
  (make-pathname
   :name :wild
   :type #-clisp :wild #+clisp nil
   :defaults (pathname-as-directory dirname)))

(defun list-directory (dirname)
  (when (wild-pathname-p dirname)
    (error "Can only list concretedirectory names."))
  (directory (directory-wildcard dirname)))

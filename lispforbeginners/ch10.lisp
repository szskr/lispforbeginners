;;
;; Chapter 10
;;

;;
;; subst defined in p.156
;;
(defun subst0 (new old tree)
  (cond ((eq old tree) new)
	((atom tree) tree)
	(t (cons (subst0 new old (car tree))
		 (subst0 new old (cdr tree)) ))))

;;
;; copy defined in p.158
;;
(defun copy (tree)
  (cond ((atom tree) tree)
	(t (cons (copy (car tree))
		 (copy (cdr tree))))))

;;
;; subst defined in p.160
;;
(defun subst1 (new old tree)
  (cond ((eq old tree) new)
	((atom tree) tree)
	(t (let ((a (subst0 new old (car tree)))
		 (d (subst0 new old (cdr tree))))
	     (cond ((and (eq a (car tree))
			 (eq d (cdr tree)))
		    tree)
		   (t (cons a d)) )))))

;;
;; sublis defined in p.162
;;
(defun sublis0 (alist tree)
  (let ((pair (assoc tree alist)))
    (cond (pair (cdr pair))
	  ((atom tree) tree)
	  (t (let ((a (sublis alist (car tree)))
		   (d (sublis alist (cdr tree))))
	       (cond ((and (eq a (car tree))
			   (eq d (cdr tree)))
		      tree)
		     (t (cons a d))))))))

;;
;; &rest
;;
(defun l_list (&rest x) x)

(defun echo1 (&rest x)
  x)

;;
;; defmacro
;;
(defun f_first (x)
  (car x))

(defun ff_first (x)
  (list 'car x))

(defmacro m_first (x)
  (list 'car x))

(defmacro mm_first (x)
  `(car ,x))

(defmacro if-null (nan dos1 dos2)
  `(cond ((null ,nan) ,dos1)
	 (t ,dos2)))

;;;
;;; various data
;;;

; Tree defined in p.156
(setq tree0 '(a b (b ba) nil a))
 
; Tree defined in p.157
(setq tree1 '(((a b) c) (d) (e . f) g))

;;
;;
;;
(defmacro image (var list &rest forms)
  `(let ((list ,list)
	 ($r$ nil)
	 (,var nil))
     (while (list (nreverse $r$))
       (setq ,var (pop list))
       (push (progn ,@forms) $r$) )))

;;;
;;; OnLisp: Chapter 17
;;;   Read Macro

(defun l17 ()  (load "./olCh17.lisp"))

;;
;; set-macro-character
;;
(set-macro-character #\'
		     #'(lambda (stream char)
			 (list 'quote (read stream t nil t))))

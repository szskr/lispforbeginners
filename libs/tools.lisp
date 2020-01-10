;;;
;;; Little tools
;;; 

(defmacro nl ()
  `(format t "~%"))

(defmacro comment-out (form))

(defmacro comment (str)
  `(format t "N: ~a~%" ,str))

(defun whoami ()
   #+sbcl
   (format t "SBCL~%")
   #+clisp
   (format t "CLISP~%")
   ())
   

;;;
;;; Little tools
;;; 

(defmacro nl ()
  `(format t "~%"))

(defun help(&optional chp)
  (chap03)
  (chap04)
  (chap05)
  (chap06)
  (chap07)
  (chap08)
  (chap09)
  (chap16)
  (chap17)
  (chap19)
  (chap20)
  (chap21))

(defun chap03 ()
  (format t "Chapter  3: Practical: A Simple Database~%"))

(defun chap04 ()
  (format t "Chapter  4: Syntax and Semantics~%"))

(defun chap05 ()
  (format t "Chapter  5: Functions~%"))

(defun chap06 ()
  (format t "Chapter  6: Variables~%"))

(defun chap07 ()
  (format t "Chapter  7: Macros:Standard Control Constructs~%"))

(defun chap08 ()
  (format t "Chapter  8: Macros: Defining Your Own~%"))

(defun chap09 ()
  (format t "Chapter  9: Practical: Builing a Unit Test Framework~%"))

(defun chap16 ()
  (format t "Chapter 16: Object Reorientation: General Functions~%"))

(defun chap17 ()
  (format t "Chapter 17: Object Reorientation: Classes~%"))

(defun chap19 ()
  (format t "Chapter 19: Beyond Exception Handling: Condition and Restarts~%"))

(defun chap20 ()
  (format t "Chapter 20: The Special Operators~%"))

(defun chap21 ()
  (format t "Chapter 21: Programming in the Large: Packages and Symbols~%"))

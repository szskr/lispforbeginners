;;;
;;; Little tools
;;; 

(defmacro nl ()
  `(format t "~%"))

(defmacro comment (str)
  `(format t "N: ~a~%" ,str))

;;
;; experiments
;;
(defun help-e ()
  (block
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
   (chap21)))

(defun help(&optional chp)
  (chap03)
  (chap04)
  (chap05)
  (chap06)
  (chap07)
  (chap08)
  (chap09)
  (chap14)
  (chap15)
  (chap16)
  (chap17)
  (chap19)
  (chap20)
  (chap21)
  (chap23)
  (chap24))

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

(defun chap14 ()
  (format t "Chapter 14: Files and File I/O~%"))

(defun chap15 ()
  (format t "Chapter 15: Practical: A Portable Pathname Library~%"))

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

(defun chap23 ()
  (format t "Chapter 23: Practical: A Spam Filter~%"))

(defun chap24 ()
  (format t "Chapter 24: Practical: Parsing Binary Files~%"))
	       
(defun l-ppcre ()
  (let ((files '("../cl-ppcre-2.1.1/packages.lisp"
		 "../cl-ppcre-2.1.1/specials.lisp"
		 "../cl-ppcre-2.1.1/util.lisp"
		 "../cl-ppcre-2.1.1/parser.lisp"
		 "../cl-ppcre-2.1.1/lexer.lisp"
		 "../cl-ppcre-2.1.1/scanner.lisp"
		 "../cl-ppcre-2.1.1/convert.lisp"
		 "../cl-ppcre-2.1.1/chartest.lisp"
		 "../cl-ppcre-2.1.1/errors.lisp"
		 "../cl-ppcre-2.1.1/charmap.lisp"
		 "../cl-ppcre-2.1.1/regex-class.lisp"
		 "../cl-ppcre-2.1.1/regex-class-util.lisp"
		 "../cl-ppcre-2.1.1/closures.lisp"
		 "../cl-ppcre-2.1.1/repetition-closures.lisp"
		 "../cl-ppcre-2.1.1/optimize.lisp"
		 "../cl-ppcre-2.1.1/api.lisp")))
    (mapcar #'load files)))

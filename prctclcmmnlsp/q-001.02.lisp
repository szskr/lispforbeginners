;;;
;;; 2020/01/22 Question 001
;;;   clisp: Loading this file just works. Even, (f0-foo)
;;;   sbcl:  load this file twice, and then it works. What's going on?
;;;

(defmacro m10-macro()
  '(format t "I am m10-macro()~%"))

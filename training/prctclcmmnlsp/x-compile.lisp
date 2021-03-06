;;;
;;; Compile/Compile-file/Disassemble and Related Explored
;;;

(comment "Compile/Compile-file/Disassemble and Related Explored")
(nl)

(defun xfoo (x)
  (format t "(xfoo): called~%")
  (+ x 1)
  100)

(comment "Disassemble xfoo")
(disassemble 'xfoo)

(comment "Compile xfoo")
(compile 'xfoo)
(xfoo 1)

(comment "Disassemble xfoo again")
(disassemble 'xfoo)

(defun yfoo ()
  (format t "(yfoo) called: and calling (xfo)o~%")
  (xfoo 1))

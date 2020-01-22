;;;
;;; Compile/Compile-file/Disassemble and Related Explored
;;;

(comment "Compile/Compile-file/Disassemble and Related Explored")
(nl)

;;;

(defun xfoo (x)
  (+ x 1))

(compile 'xfoo)
(xfoo 1)
(disassemble 'xfoo)

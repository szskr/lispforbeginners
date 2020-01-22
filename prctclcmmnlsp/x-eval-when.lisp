;;;
;;; Eval-when explored
;;;  REPL/load/compiler/interpreter: How are they related?
;;;

(comment "Eval-when Explored")
(nl)

(comment "run-at-compile-time() defined in run-at-compile-time.lisp")

(defmacro foo()
  (run-at-compile-time)
  '(print 'I-am-called-at-runtime))

;;;
;;; The following call to (foo) causes an error because (run-at-compile-time) is un-defined in this file.
;;;
(load "./run-at-compile-time.lisp")   ;; loaded, so the next form would work fine.
(foo)

(load "./run-at-compile-time.lisp")

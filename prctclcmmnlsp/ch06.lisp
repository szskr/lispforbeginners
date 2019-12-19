;;
;; Chapter 06: Variables
;;

(nl)
(nl)
(chap06)
(comment "Chapter 06")
(nl)

;;;
;;; Notes
;;;

;;;
;;; DYNAMICALLY TYPED
;;;  A variable can hold values of any type and the values carry type informatuib that can be used
;;;  to check types at runtime. Thus Common lisp is DYNAMICALLY TYPED.
;;;
;;; SCOPE
;;;  The SCOPE of function and LET variable is the area of the program where the variable name
;;;  can be used to refer to the variable binding.
;;;
;;; BINDING FORM
;;;  The form, function definition and LET, is called the BINDING FORM.
;;;
;;; LEXICALLY TYPED VARIABLES
;;;  All binding forms in common lisp introduce LEXICALLY SCOPED variables.
;;;  LEXICALLY TYPED VARIABLES can be refereed to only by the code that's texically within the binding form.
;;;  (In C, local variables are LEXICALLY TYPED VARIABLES.)
;;;

;;;
;;; COMMON LISP'S LEXICAL VARIABLES and CLOSURES
;;;  By the rules of lexical scoping, "only code texically within the binding form can refer to a lexical variable".
;;;
;;;  What happens when an anonymous function contains a reference to a LEXICAL VARIABLE from an enclosing SCOPE?
;;;  For instance
;;;
;;;    (let ((count 0)) #'(lambda () (setf count (1+ count))))
;;;
;;;  In the above code, the reference to count in LAMDA form should be legal according to the rules of lexical scoping.
;;;  However, the anonymous function containing the reference will be returned as the value of the LET form and
;;;   can be invoded via FUNCALL. This code may not be in the scope of the LET. So ??
;;;
;;;  It works. The binding of count created when the flow of control entered the LET form will stick around for as long as
;;;  needed, in this case for as long as someone holds onto a reference to the function object returned by the LET from.
;;;
;;;  The anonymous function is called CLOSURE because it "closes over" the binding created by LET.

(defparameter *counter*
  (let ((count 0))
    #'(lambda () (setf count (1+ count)))))

(format t "(01. funcall *counter*) = ~a~%" (funcall *counter*))
(format t "(02. funcall *counter*) = ~a~%" (funcall *counter*))
(format t "(03. funcall *counter*) = ~a~%" (funcall *counter*))

;;; 
;;; The key thing to understand about closure is that it;s the BINDING, not the value of the variable, that's captured.
;;;

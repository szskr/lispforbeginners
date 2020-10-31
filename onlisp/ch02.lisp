;;
;; Chapter 02: Functions
;;
(comment "Chap02: Functions")
(nl)

;;
;; 
;;
(comment "02.09 Compile")
(nl)

(defun foo (x) (+ 1 x))

(myformat "(compiled-function-p #'foo) = ~a~%" (compiled-function-p #'foo))
(comment "SZSKR:2020/01/21 It seems that in sbcl, defined functions are by default 'COMPILED'. ?")

(compile 'foo)

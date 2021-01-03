;;
;; Chapter 02: Functions
;;
(comment "Chap02: Functions")
(nl)

;;
;; Local Functions
(comment "02.07 Local Functions")
(setq _ch02_tval
    (labels ((inc (x) (+ 1 x))
	     (a (y) (+ (inc y) 10)))
	    (a 10)))
;;
;;
(comment "02.09 Compile")
(nl)

(defun foo (x) (+ 1 x))

(myformat "(compiled-function-p #'foo) = ~a~%" (compiled-function-p #'foo))
(comment "SZSKR:2020/01/21 It seems that in sbcl, defined functions are by default 'COMPILED'. ?")

(compile 'foo)

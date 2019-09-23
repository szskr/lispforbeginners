;;
;; Preparation for analyzing yacc.lisp:
;;;     PART 2: GRAMMAR
;;
(defun y200 () (load "./y200.lisp"))

(load "./y100.lisp")

;;;
;;; Grammars
;;;

(defstruct (grammar (:constructor %make-grammar))
  (name nil)
  (terminals '() :type list)
  (precedence '() :type list)
  (productions '() :type list)
  (%symbols :undefined :type (or list (member :undefined)))
  (derives-epsilon '() :type list)
  (derives-first '() :type list)
  (derives-first-terminal '() :type list))

(defun make-grammar(&key name (start-symbol (required-argument))
                    terminals precedence productions)
  (declare (symbol name start-symbol) (list terminals productions))
  (setq productions
        (cons (make-production 's-prime (list start-symbol)
                               :action #'identity :action-form '#'identity)
              productions))
  (do* ((i 0 (+ i 1)) (ps productions (cdr ps)) (p (car ps) (car ps)))
       ((null ps))
    (setf (production-id p) i))
  (%make-grammar :name name :terminals terminals :precedence precedence
                 :productions productions))

(defun grammar-discard-memos (grammar)
  (setf (grammar-%symbols grammar) :undefined)
  (setf (grammar-derives-epsilon grammar) '())
  (setf (grammar-derives-first grammar) '())
  (setf (grammar-derives-first-terminal grammar) '()))

(defun terminal-p (symbol grammar)
  (declare (symbol symbol) (type grammar grammar))
  (or (eq symbol 'propagate)
      (and (member symbol (grammar-terminals grammar)) t)))

(defun grammar-symbols (grammar)
  "The set of symbols (both terminal and nonterminal) of GRAMMAR."
  (declare (type grammar grammar))
  (cond
    ((eq :undefined (grammar-%symbols grammar))
     (let ((res '()))
       (dolist (p (grammar-productions grammar))
         (pushnew (production-symbol p) res)
         (dolist (s (production-derives p))
           (pushnew s res)))
       (setf (grammar-%symbols grammar) res)
       res))
    (t (grammar-%symbols grammar))))

(defun grammar-epsilon-productions (grammar)
  (remove-if-not #'(lambda (r) (null (production-derives r)))
                 (grammar-productions grammar)))

(defun derives-epsilon (symbol grammar &optional seen)
  "True if symbol derives epsilon."
  (declare (symbol symbol) (type grammar grammar) (list seen))
  (let ((e (assoc symbol (grammar-derives-epsilon grammar))))
    (cond
      (e (cdr e))
      ((terminal-p symbol grammar) nil)
      ((member symbol seen) nil)
      (t
       (let ((res (derives-epsilon* symbol grammar (cons symbol seen))))
         (when (or res (null seen))
           (setf (grammar-derives-epsilon grammar)
                 (acons symbol res (grammar-derives-epsilon grammar))))
         res)))))

(defun derives-epsilon* (symbol grammar &optional seen)
  "Unmemoised version of DERIVES-EPSILON."
  (declare (symbol symbol) (type grammar grammar) (list seen))
  (dolist (production (grammar-productions grammar))
    (when (and (eq symbol (production-symbol production))
               (every #'(lambda (s) (derives-epsilon s grammar seen))
                      (production-derives production)))
      (return t))))

(defun sequence-derives-epsilon (sequence grammar)
  "Sequence version of DERIVES-EPSILON*."
  (declare (list sequence) (type grammar grammar))
  (every #'(lambda (s) (derives-epsilon s grammar)) sequence))

(defun print-derives-epsilon (grammar &optional (stream *standard-output*))
  (let ((seen '()) (de '()))
    (dolist (p (grammar-productions grammar))
      (let ((s (production-symbol p)))
        (unless (member s seen)
          (push s seen)
          (when (derives-epsilon s grammar)
            (push s de)))))
    (format stream "~D symbols derive epsilon:~%~S~%~%"
            (length de) (nreverse de))))

(defun derives-first (c grammar &optional seen)
  "The list of symbols A such that C rm->* A.eta for some eta."
  (declare (symbol c) (type grammar grammar) (list seen))
  (let ((e (assoc c (grammar-derives-first grammar))))
    (cond
      (e (the list (cdr e)))
      ((terminal-p c grammar) (list c))
      ((member c seen) '())
      (t
       (let ((derives (list c)))
         (declare (list derives))
         (dolist (production (grammar-productions grammar))
           (when (eq c (production-symbol production))
             (setq derives
                   (union (sequence-derives-first
                           (production-derives production) grammar
                           (cons c seen))
                          derives))))
         (when (null seen)
           (setf (grammar-derives-first grammar)
                 (acons c derives (grammar-derives-first grammar))))
         derives)))))

(defun sequence-derives-first (sequence grammar &optional seen)
  "Sequence version of DERIVES-FIRST."
  (declare (list sequence) (type grammar grammar) (list seen))
  (cond
    ((null sequence) '())
    ((terminal-p (car sequence) grammar) (list (car sequence)))
    (t
     (let ((d1 (derives-first (car sequence) grammar seen)))
       (if (derives-epsilon (car sequence) grammar)
           (union d1 (sequence-derives-first (cdr sequence) grammar seen))
           d1)))))

(defun derives-first-terminal (c grammar &optional seen)
  "The list of terminals a such that C rm->* a.eta, last non-epsilon."
  (declare (symbol c) (type grammar grammar))
  (let ((e (assoc c (grammar-derives-first-terminal grammar))))
    (cond
      (e (the list (cdr e)))
      ((terminal-p c grammar) (list c))
      ((member c seen) '())
      (t
       (let ((derives '()))
         (declare (list derives))
         (dolist (production (grammar-productions grammar))
           (when (eq c (production-symbol production))
             (setq derives
                   (union
                    (sequence-derives-first-terminal
                     (production-derives production) grammar (cons c seen))
                    derives))))
         (when (null seen)
           (push (cons c derives) (grammar-derives-first-terminal grammar)))
         derives)))))

(defun sequence-derives-first-terminal (sequence grammar &optional seen)
  "Sequence version of DERIVES-FIRST-TERMINAL."
  (declare (list sequence) (type grammar grammar) (list seen))
  (cond
    ((null sequence) '())
    (t
     (derives-first-terminal (car sequence) grammar seen))))

(defun first-terminals (s grammar)
  "FIRST(s) without epsilon."
  (declare (atom s) (type grammar grammar))
  (cond
    ((terminal-p s grammar) (list s))
    (t (remove-if-not #'(lambda (s) (terminal-p s grammar))
                      (derives-first s grammar)))))

(defun sequence-first-terminals (s grammar)
  "Sequence version of FIRST-TERMINALS."
  (declare (list s) (type grammar grammar))
  (cond
    ((null s) '())
    (t (let ((sf (first-terminals (car s) grammar)))
         (if (derives-epsilon (car s) grammar)
             (union sf (sequence-first-terminals (cdr s) grammar))
             sf)))))

(defun print-first-terminals (grammar &optional (stream *standard-output*))
  "Print FIRST (without epsilon) for all symbols of GRAMMAR."
  (let ((df '()))
    (dolist (p (grammar-productions grammar))
      (let ((s (production-symbol p)))
        (unless (assoc s df)
          (push (cons s (first-terminals s grammar)) df))))
    (format stream "First terminals:~%")
    (dolist (e (nreverse df))
      (format stream "~S: ~S~%" (car e) (cdr e)))
    (format stream "~%")))

(defun sequence-first (s grammar)
  "FIRST(s)."
  (declare (list s) (type grammar grammar))
  (let ((sf (sequence-first-terminals s grammar)))
    (if (sequence-derives-epsilon s grammar)
        (cons 'epsilon sf)
        sf)))

(defun combine-first (f1 s grammar)
  "FIRST(s1.s) where f1=FIRST(s1)."
  (declare (list f1 s) (type grammar grammar))
  (if (member 'epsilon f1)
      (union (remove 'epsilon f1) (sequence-first s grammar))
      f1))

(defun relative-first (s a grammar &optional seen)
  "Union of FIRST(eta) for all the eta s.t. S rm->* Aeta."
  (declare (symbol s a) (type grammar grammar) (list seen))
  (cond
    ((terminal-p s grammar) '())
    ((member s seen) '())
    (t (let ((res '()))
         (when (and (eq s a) (derives-epsilon s grammar))
           (push 'epsilon res))
         (dolist (p (grammar-productions grammar))
           (when (and (eq s (production-symbol p))
                      (not (null (production-derives p))))
             (setf res
                   (union res
                          (relative-first-sequence
                           (production-derives p)
                           a grammar (cons s seen))))))
         res))))

(defun relative-first-sequence (s a grammar &optional seen)
  "Sequence version of RELATIVE-FIRST."
  (declare (list s seen) (symbol a) (type grammar grammar))
  (cond
    ((null s) '())
    ((equal s (list a)) (list 'epsilon))
    ((not (member a (derives-first (car s) grammar))) '())
    ((eq (car s) a) (sequence-first (cdr s) grammar))
    (t (relative-first (car s) a grammar seen))))

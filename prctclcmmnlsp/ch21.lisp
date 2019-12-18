;;
;; Chapter 21: Programming in the Large: Package and Symbols
;;

(nl)
(nl)
(chap21)
(comment "Chapter 21")
(nl)

;;;
;;; Vocabulary
;;;
;;;; PACKAGE
;;;;  A table that maps strings to symbols
;;;;
;;;; FIND-PACKAGE
;;;;  Any package has a name. This function can be used to find the package by name.
;;;;
;;;; FIND-SYMBOL/INTERN
;;;;  Functions that the reader uses to access the name-to-symbol mappings in a package.
;;;;  FIND-SYMBOL looks in the package for a symbol with the given string and returns it.
;;;;  INTERN will return an existing symbol; otherwise it creates a new symbol with the string
;;;;         as its name and adds it to the package.
;;;;
;;;; UNQUALIFIED SYMBOL NAME
;;;;  Names that contain no colons.
;;;;
;;;; PACKAGE QUALIFIED NAME
;;;;  *) A name containing either a single colon or a double colon is a PACKAGE QUALIFIED NAME.
;;;;     Example: 
;;;;     yacc::yyparse
;;;;       yacc    -> package name
;;;;       yyparse -> symbol name
;;;;  *) A name containing only a single colon must refer to an EXTERNAL symbol.
;;;;     An EXTERNAL symbol is EXPORTED by a package for public use.
;;;;
;;;; PUBLIC INTERFACE
;;;;  The set of exported symbols define a package's PUBLIC INTERFACE.
;;;;
;;;; KEYWORD SYMBOL
;;;;  KEYWORD SYMBOLS are written with names starting with a colon.
;;;;  Such symbols are INTERNed in the package named KEYWORD and automatically exported.
;;;;  When the reader INTERNs a symbol in the KEYWORD package, it also defines a constant variable
;;;;   with the symbol as both its name and value.

;;;
;;; How the Reader Uses Packages
;;;



*package*     ;; The current package
(format t "The current package is ~a " *package*)
(nl)

(format t "~a~%" (symbol-name :foo))
(format t "~a~%" (symbol-name 'foo-bar))
(format t "~a~%" (gensym))

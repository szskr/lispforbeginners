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
;;;; FIND-SYMBOL, INTERN
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
;;;;
;;;; ACCEESSIBLE SYMBOL
;;;;  All the symbols that can be found in a given package using FIND_SYMBOL function are
;;;;  said to be ACCESSIBLE in that package. ACCESSIBLE SYMBOLS in a package can be referred to
;;;;  with UNQUALFIED NAMES.
;;;;
;;;; A symbol is said to be PRESENT
;;;;  The package's name-to-symbol table contain an entry a symbol. This symbol is said to be PRESENT
;;;;  in the package.
;;;;
;;;; A symbl's HOME PACKAGE
;;;;  The package in which a symbol is first INTERNed is called the symbol's HOME PACKAGE.
;;;;
;;;; INHERIT, USE, EXTERNAL, EXPORT
;;;;  A symbol can be accessible in a package by INHERITing it from other package.
;;;;  A package INHERITs symbols from other packages by USING other packages.
;;;;  Only EXTERNAL symbols in the USED packages are EXPORTed.
;;;;
;;;;  A symbol is made EXTERNAL in a package by EXPORTing it.
;;;;
;;;; SHADOWING
;;;;  A package can not have a present symbol and an inherited symbol with the sanme name
;;;;  or inherit two different symbols, from different packages, with the same name.
;;;;   However, you can resolve conflicts by making one of the accessible symbols a ShADOWING symbol,
;;;;   which makes the other symbols fo the same name inaccessible.
;;;;  
;;;; Each package maintains a list of SHADOWING symbols in addtion to its name-to-symbol table.
;;;;
;;;; IMPORT
;;;;  An existing symbol can be IMPORTed into another package by adding it to the package's
;;;;  name-to-symbol table.
;;;;
;;;; UNINTERN
;;;;  A PRESENT symbol can be UNINTERNed from a package, which causes it to be removed from the name-to-symbol
;;;;  table and , if it has a shawowing symbol. from the shadowing list.
;;;;
;;;;  A symbol that isn't PRESENT in any package is called an UNINTERNED symbol.

;;;
;;; Three Standard Packages
;;;

*package*     ;; The current package
(format t "The current package is ~a " *package*)
(nl)

(format t "~a~%" (symbol-name :foo))
(format t "~a~%" (symbol-name 'foo-bar))
(format t "~a~%" (gensym))

(nl)
(defvar *x21* 10)
(format t "*x21* = ~a~%" *x21*)
(format t "common-lisp-user::*x21* = ~a~%" common-lisp-user::*x21*)
common-lisp-user::*x21*

;;;
;;; Defining Your Own Packages
;;;

(defpackage :prcl.ch21.01
  (:use :common-lisp))

(defpackage :prcl.ch21.02)

(in-package :prcl.ch21.01)

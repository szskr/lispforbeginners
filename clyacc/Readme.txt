
1. Introduction

In "The CL-Yacc Manual" at the section 2.3, "2.3 Functionalinterface", it
starts as:

  The macros define-parser and define-grammarexpand into calls to
  defparameter, make-parser, make-grammar and make-production with
  suitable make-load-form magic to ensure that the time consuming parser
  generation happens at compile time rather that at load time.

How macros are used and what is make-load-form magic?

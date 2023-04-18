;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../vendor
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: ./tests/records.sps
#!r6rs
;; Copyright 2010 Derick Eddington.  My MIT-style license is in the file named
;; LICENSE from the original collection this file is distributed with.
(import
  (rnrs base)
  (srfi :78 lightweight-testing)
  (srfi :9 records))
(define unspec)
(define-record-type T0 (make-T0) T0?)
(check (T0? (make-T0)) => #t)
(define-record-type T1 (make-T1) T1? (x T1-x))
(check (T1? (make-T1)) => #t)
(check (T1-x (make-T1)) => unspec)
(define-record-type T2 (make-T2 y x) T2? (x T2-x) (y T2-y))
(let ([o (make-T2 1 2)])
  (check (T2? o) => #t)
  (check (T2-x o) => 2)
  (check (T2-y o) => 1))
(define-record-type T3
  (make-T3 z)
  T3?
  (x T3-x set-T3-x!)
  (y T3-y)
  (z T3-z))
(let ([o (make-T3 1)])
  (check (T3? o) => #t)
  (check (T3-x o) => unspec)
  (check (T3-y o) => unspec)
  (check (T3-z o) => 1)
  (set-T3-x! o 2)
  (check (T3-x o) => 2))
(check-report)

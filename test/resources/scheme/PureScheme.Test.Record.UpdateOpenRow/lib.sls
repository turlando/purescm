(library
  (PureScheme.Test.Record.UpdateOpenRow lib)
  (export foo)
  (import (rnrs))


  (define
    foo
    (lambda
      (v)
      (let
        (($ht (hashtable-copy v)))
        (begin (hashtable-set! $ht "bar" 42) $ht))))
  )
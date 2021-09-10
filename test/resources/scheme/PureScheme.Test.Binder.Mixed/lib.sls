(library
  (PureScheme.Test.Binder.Mixed lib)
  (export foo)
  (import
    (rnrs)
    (prefix (Data.Semiring lib) Data.Semiring.)
    (prefix (Prelude lib) Prelude.))


  (define
    foo
    (lambda
      (v)
      (lambda
        (v1)
        (cond
          ((and (= v 0) (= v1 0)) 0)
          ((and (= v 0) (= v1 1)) 1)
          ((and (= v 1) (= v1 0)) 10)
          ((= v1 2) 2)
          ((= v 3) 30)
          ((= v 4) v1)
          ((= v1 5) v)
          (#t (+ v v1))
          (else (error #f "Failed pattern match"))))))
  )
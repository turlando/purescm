(library
  (PureScheme.Test.Recursion.Fibonacci lib)
  (export fib)
  (import
    (rnrs)
    (prefix (Data.Ring lib) Data.Ring.)
    (prefix (Data.Semiring lib) Data.Semiring.)
    (prefix (Prelude lib) Prelude.))


  (define
    fib
    (lambda
      (v)
      (cond
        ((= v 0) 0)
        ((= v 1) 1)
        (#t (+ (fib (- v 1)) (fib (- v 2))))
        (else (error #f "Failed pattern match")))))
  )
(library (PureScheme.Test.Binder.Guard lib) (export match) (import (rnrs) (prefix (Data.Boolean lib) Data.Boolean.) (prefix (Data.Eq lib) Data.Eq.) (prefix (Prelude lib) Prelude.) (prefix (Prim lib) Prim.)) (define match (lambda (dictPartial) (lambda (v) (lambda (a) (cond ((= v 1) (cond ((((Data.Eq.eq Data.Eq.eqInt) a) 2) 3) ((((Data.Eq.eq Data.Eq.eqInt) a) 4) 5) (Data.Boolean.otherwise 6) (else (error #f "Failed pattern match")))) (else (error #f "Failed pattern match"))))))))
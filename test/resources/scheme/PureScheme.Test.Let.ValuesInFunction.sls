(library (PureScheme.Test.Let.ValuesInFunction lib) (export foo) (import (rnrs)) (define foo (lambda (x) (lambda (y) (let ((b 2) (a 1)) (- (+ x a) (+ y b)))))))
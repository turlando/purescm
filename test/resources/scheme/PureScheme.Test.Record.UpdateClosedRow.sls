(define foo (let (($ht (make-hashtable string-hash string=? 2))) (begin (hashtable-set! $ht "bar" 23) (hashtable-set! $ht "baz" 42) $ht)))

(define foo' (let ((v foo)) (let (($ht (make-hashtable string-hash string=? 2))) (begin (hashtable-set! $ht "bar" 69) (hashtable-set! $ht "baz" 420) $ht))))
(define antani (let ((foo (let (($ht (make-hashtable string-hash string=? 2))) (begin (hashtable-set! $ht "bar" 23) (hashtable-set! $ht "baz" 42) $ht)))) (let ((v foo)) (let (($ht (make-hashtable string-hash string=? 2))) (begin (hashtable-set! $ht "bar" 69) (hashtable-set! $ht "baz" (hashtable-ref v "baz" (error #f "Key not found"))) $ht)))))
(library
  (PureScheme.Test.ReExport.Bar lib)
  (export bar)
  (import (rnrs))


  (define bar 2)
  )
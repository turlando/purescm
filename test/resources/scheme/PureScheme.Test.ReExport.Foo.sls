(library (PureScheme.Test.ReExport.Foo lib) (export foo) (import (rnrs) (prefix (Prim lib) Prim.)) (define foo 1))
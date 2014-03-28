
(define-library (piika cli)
    (export run)
  (import (scheme base)
          (scheme file)
          (scheme read)
          (scheme eval)
          (scheme load)
          (scheme process-context)
          (gauche base)
          (gauche process)
          (piika task))
  (begin

    (define (run args)
      (run-process `(gosh -r7 "Piikafile" ,@(cdr (command-line)))
                   :wait #t))

    ))

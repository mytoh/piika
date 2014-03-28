;;; piika.scm

(define-library (piika)
    (export define-task
            run-task)
  (import (scheme base)
          (scheme write)
          (gauche base)
          (piika task))
  )


;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

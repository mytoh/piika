;;; task.scm

(define-library (piika task)
    (export define-task
            run-task)
  (import (scheme base)
          (scheme write)
          (scheme process-context)
          (srfi 1)
          (gauche base))

  (begin

    (define *piika-tasks* (make-parameter '()))

    (define (get-tasks)
      (*piika-tasks*))

    (define-syntax define-task
      (syntax-rules ()
        ((_ name (dep ...) body ...)
         (*piika-tasks*
          (cons
              (make-task
               'name
               (list 'dep ...)
               (lambda () body ...))
            (get-tasks))))))

    (define-record-type <task>
      (make-task
       name
       deps
       body)
      task?
      (name task.name set-task.name)
      (deps task.deps set-task.deps)
      (body task.body set-task.body))

    (define (find-task task-name tasks)
      (find (lambda (t)
              (equal? task-name (task.name t)))
        tasks))

    (define (do-task task)
      (cond
        ((null? (task.deps task))
         ((task.body task)))
        (else
            (for-each
                (lambda (t)
                  (do-task (find-task t (get-tasks))))
              (task.deps task))
          ((task.body task)))))

    (define (run-task)
      (let* ((tasks (get-tasks))
             (args (cdr (command-line)))
             (task-name (string->symbol (car args))))
        (do-task (find-task task-name tasks))))

    ))

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

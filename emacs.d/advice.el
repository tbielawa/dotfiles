;; -*- mode: emacs-lisp -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Really, why would I want *.pyc in my filename tab completion?
(defadvice completion--file-name-table (after
                                        ignoring-backups-f-n-completion
                                        activate)
  "Filter out results when the have completion-ignored-extensions"
  (let ((res ad-return-value))
    (if (and (listp res)
             (stringp (car res))
             (cdr res))                 ; length > 1, don't ignore sole match
        (setq ad-return-value
              (completion-pcm--filename-try-filter res)))))

;; -*- mode: emacs-lisp -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add a new DocBook 5 compliant section
(defun db-new-section (xml-id title)
  (interactive "sxml-id:\nsTitle:")
  (save-excursion
    (let
	((nl))
      (setq nl "
")
      (insert "<section xml:id=\"" xml-id "\">" nl nl "  <title>" title "</title>" nl nl "<para>" nl nl "</para>" nl nl "</section>" nl nl ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cycle through windows the other way with previous-window
(defun previous-window ()
  "As other-buffer, except in the other-direction"
  (interactive)
  (other-window -1))
(global-set-key "\C-x\p" 'previous-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Delete all that nasty whitespace that doesn't belong.
;;(show-ws-toggle-show-trailing-whitespace)
(defun delete-trailing-whitespace-except-current-line ()
  (interactive)
  (let ((begin (line-beginning-position))
        (end (line-end-position)))
    (save-excursion
      (when (< (point-min) begin)
        (save-restriction
          (narrow-to-region (point-min) (1- begin))
          (delete-trailing-whitespace)))
      (when (> (point-max) end)
        (save-restriction
          (narrow-to-region (1+ end) (point-max))
          (delete-trailing-whitespace))))))
;;(add-hook 'before-save-hook 'delete-trailing-whitespace-except-current-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indent the entire buffer -- at once!
(defun indent-buffer ()
  "Indents an entire buffer using the default intenting scheme."
  (interactive)
  (point-to-register 'o)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (jump-to-register 'o))

(global-set-key "\C-x\\" 'indent-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; word-wrap, or "toggle-truncate-lines" as they say
(defun word-wrap()
  (interactive)
  (toggle-truncate-lines))

(global-set-key "\C-ct" 'word-wrap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; We should avoid trying to launch OfflineIMAP multiple times.
;; OfflineIMAP will quit on its own, but we'll get nasty error
;; messages
(defun offlineimap-runningp ()
  "Tell us if the Offlineimap process is already running or not."
  (interactive)
  (let
      ((imap-buffer (get-buffer "*OfflineIMAP*")))
    (if (null imap-buffer)
	nil
      t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lets get some email going!
(defun email()
  "Notmuch mail client and the imap poller"
  (interactive)
  (load-file "~/.emacs.d/notmuch-config.el")
  (if (null (offlineimap-runningp))
      (offlineimap))
  (notmuch)
  (color-theme-deep-blue))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add a new task to the docs
(defun taboot-new-task (task-name)
  (interactive "sTask Name:")
  (insert-file "task")
  (replace-string "*name*" task-name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Your amazing function here!


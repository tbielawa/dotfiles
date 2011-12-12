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
;; Run the spellchecker
(global-set-key "\C-c\C-f" 'flyspell-buffer)

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
  (if (null (get-buffer "*notmuch-hello*"))
      (progn
        (color-theme-twilight)
        (notmuch)
        t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add a new task to the docs
(defun taboot-new-task (task-name)
  (interactive "sTask Name:")
  (insert-file "task")
  (replace-string "*name*" task-name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Your amazing function here!
(defun toggle-mail-buffers ()
  "Toggle back and forth between notmuch and offlineimap"
  (interactive)
  (unless (email)
    (let ((cb (buffer-name))
          (nm "*notmuch-hello*")
          (oi "*OfflineIMAP*"))
      (message "Current buffer: %s" cb)
      (if (string= cb nm) ;; if current buffer is notmuch, switch to offlineimap
          (progn
            (message "If! (cb is nm)")
            (message "Switching to %s from %s" oi cb)
            (switch-to-buffer oi)
	    (goto-char (point-max)))
        ;; else (curbuf is offlineimap, switch to notmuch
        (progn
          (message "Else! (cb is not nm)")
          (message "Switching to %s from %s" nm cb)
          (switch-to-buffer nm)
	  (notmuch-hello-update)
          )))))

  ;; (global-set-key "\M-O" 'toggle-mail-buffers)

;; Quick puppet selector. Don't give dollar signs in the first prompt
(defun puppet-insert-selector (var default-value)
  "Insert a puppet selector statement with the given default."
  (interactive "sVariable name:\nsDefault value:")
  (save-excursion
    (indent-relative-maybe)
    (let
        ((varname (concat "$" var)))
      (insert varname " = " varname " ? {\n")
      (puppet-indent-line)
      ;; (indent-relative-maybe)
      (insert "''      => " default-value ",\n")
      (puppet-indent-line)
      ;; (indent-relative-maybe)
      (insert "default => " varname ",\n")
      (puppet-indent-line)
      ;;(indent-relative-maybe)
      (insert "}")
      (puppet-indent-line)
      (end-of-line)
      (insert "\n"))))

;; de-wordwrap everything
(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))
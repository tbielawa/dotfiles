(setq notmuch-saved-searches '(
                               ;; ("Anderson" . "tag:anderson")
                               ("Meetings" . "tag:meetings")
                               ("INFO" . "tag:INFO")
                               ("inbox" . "tag:inbox and tag:unread")
                               ("TODO" . "tag:TODO or tag:todo")
                               ("versionmerge" . "tag:versionmerge")
                               ("Problems" . "(tag:outages or tag:gomez or tag:nagios) and tag:unread")
                               ("Taboot" . "tag:taboot and tag:unread")
                               ("FedoraDevel" . "tag:fedora-devel and tag:unread")
                               ("FuncList" . "tag:func-list and tag:unread")
                               ("RDUList" . "tag:rdu-list and tag:unread")
                               ("rh-ea-list" . "tag:rh-ea-list and tag:unread")
                               ("unread" . "tag:unread and not tag:notmuch")
                               ))


(defun notmuch-search-tag-and-advance (&rest tags)
  "Apply a tag or set of tags to the current thread.

Shortcut to simplify applying tags in search mode. Targeted for
use in key-bound functions. Advances to the next thread after
applying the tags."
  (mapc 'notmuch-search-tag-thread tags)
  (notmuch-search-next-thread))

(defun notmuch-search-mark-as-read ()
  "In search mode, remove the unread tag from a thread"
  (interactive)
  (notmuch-search-tag-and-advance "-unread"))

;; The tag-and-advance function accepts multiple tags at once
(defun notmuch-search-mark-as-spam ()
  "Mark this thread as spam"
  (interactive)
  (notmuch-search-tag-and-advance "-unread" "-inbox" "+spam"))

(defun notmuch-search-add-todo ()
  "Add 'TODO' tag when in search-mode"
  (interactive)
  (notmuch-search-tag-and-advance "+TODO"))

(defun notmuch-search-remove-todo ()
  "Remove a 'TODO' tag in search mode"
  (interactive)
  (notmuch-search-tag-and-advance "-TODO"))


(define-key notmuch-search-mode-map "u" 'notmuch-search-mark-as-read)
(define-key notmuch-search-mode-map (kbd "S-<f9>") 'notmuch-search-remove-todo)
(define-key notmuch-search-mode-map (kbd "<f9>") 'notmuch-search-add-todo)

(defun notmuch-refresh-unstupify ()
  "Fix the point appearing in random locations when refreshing
the hello screen"
  (goto-char (point-min))
  (goto-char (or (search-forward "unread" nil t)
                 (search-forward "inbox" nil t)))
  (backward-word))
(add-hook 'notmuch-hello-refresh-hook 'notmuch-refresh-unstupify)
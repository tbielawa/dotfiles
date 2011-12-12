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
                               ("unread" . "tag:unread")
                               ))

(defun notmuch-search-delete ()
  "Remove 'unread' tag"
  (interactive)
  (notmuch-search-remove-tag "unread")
  (forward-line))

(defun notmuch-add-todo ()
  "Add 'TODO' tag"
  (interactive)
  (if (string-equal major-mode "notmuch-show-mode")
      (notmuch-show-add-tag "TODO")
    (notmuch-search-add-tag "TODO"))
  (forward-line))

(defun notmuch-remove-todo ()
  "Remove 'TODO' tag"
  (interactive)
  (if (string-equal major-mode "notmuch-show-mode")
      (notmuch-show-remove-tag "TODO")
    (notmuch-search-remove-tag "TODO"))
  (forward-line))

(define-key notmuch-search-mode-map "u" 'notmuch-search-delete)
(define-key notmuch-search-mode-map (kbd "S-<f9>") 'notmuch-remove-todo)
(define-key notmuch-search-mode-map (kbd "<f9>") 'notmuch-add-todo)
(define-key notmuch-show-mode-map (kbd "S-<f9>") 'notmuch-remove-todo)
(define-key notmuch-show-mode-map (kbd "<f9>") 'notmuch-add-todo)

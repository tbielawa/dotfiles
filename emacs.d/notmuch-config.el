(setq notmuch-saved-searches '(
			       ("QA Migration" . "tag:QA")
			       ("Anderson" . "tag:anderson")
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

(define-key notmuch-search-mode-map "u" 'notmuch-search-delete)

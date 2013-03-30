;; -*- mode: emacs-lisp -*-
(load-file "~/.emacs.d/modes.el")
(load-file "~/.emacs.d/defuns.el")
(load-file "~/.emacs.d/defuns-juicer.el")
(load-file "~/.emacs.d/advice.el")

(column-number-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying t)
 '(backup-by-copying-when-linked t)
 '(backup-directory-alist (quote (("\".\"" . "~/.emacs.d/auto-save-list"))))
 '(coffee-tab-width 4)
 '(display-time-24hr-format t)
 '(display-time-day-and-date nil)
 '(display-time-mode t)
 '(graphviz-dot-indent-width 4)
 '(graphviz-dot-toggle-completions t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-echo-area-message "tbielawa")
 '(inhibit-startup-screen t)
 '(initial-major-mode (quote text-mode))
 '(initial-scratch-message nil)
 '(ispell-personal-dictionary "~/.aspell.en.pws")
 '(js2-strict-trailing-comma-warning nil)
 '(mail-host-address "redhat.com")
 '(make-backup-files t)
 '(menu-bar-mode nil)
 '(message-from-style (quote angles))
 '(message-kill-buffer-on-exit t)
 '(message-send-mail-function (quote sendmail-query-once))
 '(notmuch-saved-searches (quote (("Meetings" . "tag:meetings") ("INFO" . "tag:INFO") ("inbox" . "tag:inbox and tag:unread") ("TODO" . "tag:TODO or tag:todo") ("versionmerge" . "tag:versionmerge") ("Problems" . "(tag:outages or tag:gomez or tag:nagios) and tag:unread") ("Taboot" . "tag:taboot and tag:unread") ("FedoraDevel" . "tag:fedora-devel and tag:unread") ("FuncList" . "tag:func-list and tag:unread") ("RDUList" . "tag:rdu-list and tag:unread") ("rh-ea-list" . "tag:rh-ea-list and tag:unread") ("unread" . "tag:unread and not tag:notmuch") ("recentemail" . "1340510400..1343173172 and not tag:nagios and not tag:cron-fail and not tag:gomez and not tag:csee"))))
 '(notmuch-search-oldest-first nil)
 '(notmuch-show-all-tags-list t)
 '(nxml-slash-auto-complete-flag t)
 '(puppet-include-indent 4)
 '(puppet-indent-level 4)
 '(scroll-bar-mode nil)
 '(scroll-step 1)
 '(send-mail-function (quote sendmail-send-it))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(user-full-name "Tim Bielawa")
 '(vc-follow-symlinks t)
 '(version-control (quote never))
 '(yaml-indent-offset 4))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defalias 'cr 'comment-region)
(defalias 'ur 'uncomment-region)

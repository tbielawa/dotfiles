;; -*- mode: emacs-lisp -*-
(load-file "~/.emacs.d/modes.el")
(load-file "~/.emacs.d/defuns.el")

(column-number-mode)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(backup-by-copying t)
 '(backup-by-copying-when-linked t)
 '(backup-directory-alist (quote (("\".\"" . "~/.emacs.d/auto-save-list"))))
 '(display-time-24hr-format t)
 '(display-time-day-and-date nil)
 '(display-time-mode t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-echo-area-message "tbielawa")
 '(inhibit-startup-screen t)
 '(initial-major-mode (quote text-mode))
 '(initial-scratch-message nil)
 '(mail-from-style (quote angles))
 '(mail-user-agent (quote message-user-agent))
 '(make-backup-files t)
 '(menu-bar-mode nil)
 '(notmuch-saved-searches (quote (("auto-spam" . "(tag:nagios or tag:gomez) and tag:unread") ("inbox" . "tag:inbox") ("unread" . "tag:unread"))))
 '(notmuch-show-all-tags-list t)
 '(nxml-slash-auto-complete-flag t)
 '(puppet-indent-level 4)
 '(scroll-bar-mode nil)
 '(scroll-step 1)
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(user-mail-address "tbielawa@redhat.com")
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


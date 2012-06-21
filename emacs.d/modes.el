;; -*- mode: emacs-lisp -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Add my emacs dir to the load path?
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/color-themes/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/rhtml/")

;;; XML Editing Mode (Mostly DocBook)
(setq auto-mode-alist
      (cons '("\\.\\(XML\\|xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))

;;; Actual LDAP Mode - For things like editing LDIFs or schemas
(require 'rhtml-mode)
(setq auto-mode-alist
      (cons '("\\.\\(erb\\|rhtml\\)\\'" . rhtml-mode)
            auto-mode-alist))

;;; Actual LDAP Mode - For things like editing LDIFs or schemas
(require 'ldap-mode)
(setq auto-mode-alist
      (cons '("\\.\\(schema\\|ldif\\|ldiff\\)\\'" . ldap-mode)
            auto-mode-alist))

;;; My generalized LDAP module, pretty much just for searching
(load-file "~/.emacs.d/site-lisp/ldap-ops-mode.el")

;;; Graphviz mode
(setq auto-mode-alist
      (cons '("\\.\\(gvz\\|gv\\)\\'" . graphviz-dot-mode)
            auto-mode-alist))
(require 'graphviz-dot-mode)

;;; YAML Files
(require 'yaml-mode)
(setq auto-mode-alist
      (cons '("\\.\\(yaml\\|yml\\)\\'" . yaml-mode)
            auto-mode-alist))
;; Hook for editing yaml files
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;; Lets generalize for a moment. Keep host specific stuff out of the way
(let
    ((hostname (getenv "HOSTNAME")))
  (if (string-equal hostname "deepfryer.rdu.redhat.com")
      (progn
        ;;; Lets get our email syncing in the background while running 'email'
        (require 'offlineimap)
        ;;; Then we can think about the mail reader
        (require 'notmuch)
        ;; Sign messages by default (http://notmuchmail.org/emacstips/#index11h2)
        (add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)
        ;; Remedy tag hooks
        (require 'remedy-tag-mode)
        (global-set-key (kbd "<f8>") 'toggle-mail-buffers))))

;;; Puppet mode for editing manifests
(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(setq auto-mode-list
      (cons '("\\.pp$" . puppet-mode)
            auto-mode-alist))

;;; Colors are cool, yeahhhhhhh
(require 'color-theme)
(require 'color-theme-tango)
(require 'color-theme-twilight)
(require 'color-theme-djcb-dark)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-twilight)))

;; For days when the urge to write some erlang for great good strikes
;; (setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.5/emacs"
;;                    load-path))
;; (setq erlang-root-dir "/usr/local/lib/erlang/")
;; (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
;; (require 'erlang-start)

(autoload 'doc-mode "doc-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.asciidoc$" . doc-mode))
(add-hook 'doc-mode-hook
          '(lambda ()
             (turn-on-auto-fill)
             (require 'asciidoc)))

;; Autocomplete mode has no idea what puppet mode is. Remedy that:
(add-to-list 'ac-modes 'puppet-mode)

;; bbdb->personal dictionary, also enable for mail mode
(require 'bbdb-spell)
(require 'flyspell)
(dolist (hook '(message-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

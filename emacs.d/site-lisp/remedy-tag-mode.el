;;; remedy-tag-mode.el -- Minor mode for opening remedy tags
;;
;; Description: 
;; 
;;   Dealing with Remedy is suck. Remedy not including actual
;;   hyperlinks to tickets in its own outgoing email is just
;;   wrong. `remedy-tag-mode` tries to make your life better by making
;;   those otherwise useless remedy tags do something.
;;
;;   Looks through the buffer for words that match the form of remedy
;;   ticket tags (INC0000001, CRQ020202020, etc...). If the word at
;;   point is a tag `remedy-tag-mode` lets you open them in a browser
;;   by pressing a key binding: C-h C-r by default.
;;
;;   Originally intended to be loaded up with emacs based mail user
;;   agents (notmuch specifically).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Patches/Updates/Changes:
;;
;;     `remedy-tag-mode` is part of the emacs-foo dist.
;;
;;     Maintained by: Tim Bielawa <tbielawa@redhat.com>
;;
;;     See on internets: http://git.corp.redhat.com/cgit/RE/emacs-foo/
;;     Clone from: git://git.corp.redhat.com/srv/git/RE/emacs-foo/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Future improvements:
;;
;;   Actually be a minor mode.
;;   Set a mode-level keymap
;;   Add Text Properties to identified Remedy Tag strings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(provide 'remedy-tag-mode)

(defun remedy-tag-launch-in-browser()
  "Launch a browser to the Remedy ticket specified by the tag at point."
  (interactive)
  (let*
      ((this-word (current-word))
       (good-tag (remedy-tagp this-word)))
    (if good-tag
	(let*
	    ((remedy-base-url "http://www.re.redhat.com/")
	     (remedy-complete-url (concatenate 'string remedy-base-url this-word)))
	  (print (concatenate 'string "Opening TAG in Firefox: " this-word))
	  (start-process-shell-command "firefox" "*remedy-ticket*" "firefox" remedy-complete-url))
      (print "Word at point is not valid Remedy tag syntax."))))

(global-set-key (kbd "C-h C-r") 'remedy-tag-launch-in-browser)

(defun remedy-tagp(remedy-tag)
  "One day this will be a beautiful function able to tell if the 
word-at-point is a legit Remedy tag. Until then, don't do anything
stoopid because it always returns true.

Use this form: (INC|CRQ|PBI|PKE)(\d{12})"
  ;;(thing2 (thing-at-point-looking-at "\(INC\|CRQ\|PBI\|PKE\)\([0-9]\{1,12\}\)"))
  ;; I'm rather ticked that thing-at-point-looking-at refuses to accept a REGEXP as advertised
  t)

(defun db-tag (tag)
  (save-excursion
    (insert "<" tag ">")
    (forward-word)
    (nxml-finish-element)
    (fill-paragraph)))

(defun db-command ()
  (interactive)
  (db-tag "command"))

(defun db-option ()
  (interactive)
  (db-tag "option"))

(defun tag-region (b e tag)
  "'tag' a region"
  (interactive "r")
  (save-excursion
      (goto-char e)
      (insert (format "</filename>"))
      (goto-char b)
      (insert (format "<filename>"))))

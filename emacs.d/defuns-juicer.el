(defun juicer-log(level msg)
  "Write the python statement for adding a log entry"
  (save-excursion
    (indent-relative-maybe)
    (insert "juicer.utils.Log.log_" level "(" msg ")")))

(defun juicer-log-debug (message)
  (interactive "sMessage (Don't forget quotes!):\n")
  (juicer-log "debug" message))

(defun juicer-log-error (message)
  (interactive "sMessage (Don't forget quotes!):\n")
  (juicer-log "error" message))

(defun juicer-log-warn (message)
  (interactive "sMessage (Don't forget quotes!):\n")
  (juicer-log "warn" message))

(defun juicer-log-info (message)
  (interactive "sMessage (Don't forget quotes!):\n")
  (juicer-log "info" message))

(defun juicer-log-notice (message)
  (interactive "sMessage (Don't forget quotes!):\n")
  (juicer-log "notice" message))

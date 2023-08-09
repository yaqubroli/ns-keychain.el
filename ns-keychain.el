(defun ns-keychain-add-generic-password (service account password)
  "Add a generic password to macOS's OS-wide keychain. SERVICE and ACCOUNT are strings. PASSWORD is a string or nil."
  ;; Interactively, prompt for the service and account name.
  (interactive "sService: \nsAccount: \nsPassword: ")
  (let ((password (if (string= password "") nil password)))
    (shell-command-to-string
     (format "security add-generic-password -s %s -a %s -w %s"
	     (shell-quote-argument service)
	     (shell-quote-argument account)
	     (shell-quote-argument password)))))

(defun ns-keychain-add-internet-password (server account password)
  "Add an internet password to macOS's OS-wide keychain. SERVER and ACCOUNT are strings. PASSWORD is a string or nil."
  ;; Interactively, prompt for the server and account name.
  (interactive "sServer: \nsAccount: \nsPassword: ")
  (let ((password (if (string= password "") nil password)))
    (shell-command-to-string
     (format "security add-internet-password -s %s -a %s -w %s"
	     (shell-quote-argument server)
	     (shell-quote-argument account)
	     (shell-quote-argument password)))))

(defun ns-keychain-get-generic-password (service account)
  "Get the password for SERVICE and ACCOUNT from macOS's OS-wide keychain."
  ;; Interactively, prompt for the service and account name.
  (interactive "sService: \nsAccount: ")
  (let ((output (shell-command-to-string
                 (format "security find-generic-password -s %s -a %s -w"
                         (shell-quote-argument service)
                         (shell-quote-argument account)))))
    (substring output 0 (string-match "\n\\'" output))))

(defun ns-keychain-get-internet-password (server account)
  "Get the password for SERVER and ACCOUNT from macOS's OS-wide keychain."
  ;; Interactively, prompt for the server and account name.
  (interactive "sServer: \nsAccount: ")
  (let ((output (shell-command-to-string
                 (format "security find-internet-password -s %s -a %s -w"
                         (shell-quote-argument server)
                         (shell-quote-argument account)))))
    (substring output 0 (string-match "\n\\'" output))))

(provide 'ns-keychain)

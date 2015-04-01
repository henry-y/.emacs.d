(defvar dcpl-mode-hook nil)

(defun dcpl-current-line-contents ()
  "Current line string without properties."
  (buffer-substring-no-properties (point-at-bol) (point-at-eol)))

(defconst dcpl--include-regexp
  "\\`\\s-*\\(?:#include\\|include\\)\\s-+\\(.*\\)")

(defconst dcpl--call-regexp
  "\\`\\s-*call\\s-+\\(.*\\)")

;; (defun dcpl-find-definition ()
;;   "Find symbol definition."
;;   (interactive)
;;   (let ((line (dcpl-current-line-contents)))
;;     (if (string-match dcpl--call-regexp line)
;;         (let ((helm-gtags-use-input-at-cursor t))
;;           (helm-gtags-find-files (concat "/" (match-string-no-properties 1 line))))
;;       (if (thing-at-point 'symbol)
;;           (helm-gtags-find-tag-from-here)
;;         (call-interactively 'helm-gtags-find-tag)))))

(defun dcpl-find-definition ()
  "Find symbol definition."
  (interactive)
  (let ((line (dcpl-current-line-contents)))
    (if (string-match dcpl--include-regexp line)
	(let ((helm-gtags-use-input-at-cursor t))
	  (helm-gtags-find-files (concat "/" (match-string-no-properties 1 line))))
      (if (string-match dcpl--call-regexp line)
	  (let ((helm-gtags-use-input-at-cursor t))
	    (helm-gtags-find-files (concat "/" (match-string-no-properties 1 line) ".d" )))))))

(defun dcpl-find-references ()
  "Find symbol references."
  (interactive)
  (let ((line (dcpl-current-line-contents)))
    (if (thing-at-point 'symbol)
	(helm-gtags-find-tag-from-here)
      (call-interactively 'helm-gtags-find-tag))))

(defun dcpl-previous-location ()
  "Jump to previous location on context stack."
  (interactive)
  (helm-gtags-previous-history))

(defun dcpl-next-location ()
  "Jump to next location on context stack."
  (interactive)
  (helm-gtags-next-history))

(defvar dcpl-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "M-.") 'dcpl-find-definition)
    (define-key map (kbd "M-]") 'dcpl-find-references)
    (define-key map (kbd "M-*") 'dcpl-previous-location)
    (define-key map (kbd "M-(") 'dcpl-next-location)
    map)
  "Keymap for DCPL major mode")

(add-to-list 'auto-mode-alist '("\\.\\(d\\|def\\)\\'" . dcpl-mode))

(defun check_symbol()
  "print current symbol."
  (interactive)
  (message "%s" (thing-at-point 'symbol)))

(defvar dcpl-mode-syntax-table
  (let ((dcpl-mode-syntax-table (make-syntax-table (standard-syntax-table))))
    (modify-syntax-entry ?& "/" dcpl-mode-syntax-table)
    (modify-syntax-entry ?% "/" dcpl-mode-syntax-table)
    (modify-syntax-entry ?= "." dcpl-mode-syntax-table)
    dcpl-mode-syntax-table)
  "Syntax table for dcpl-mode")

(defun dcpl-mode ()
  "Major mode for editing Digital Communications Programming Language (DCPL)"
  (interactive)
  (kill-all-local-variables)
  (use-local-map dcpl-mode-map)
  (set-syntax-table dcpl-mode-syntax-table)
  (setq major-mode 'dcpl-mode)
  (setq mode-name "DCPL")
  (run-hooks 'dcpl-mode-hook))

(provide 'dcpl-mode)

(require 'org-mouse)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-catch-invisible-edits t)
(setq org-startup-indented t)
(setq org-src-fontify-natively t)
(setq org-fontify-whole-heading-line t)


(setq org-emphasis-alist
	 (quote (("*" (:foreground "red"))
			 ("/" italic)
			 ("_" underline)
			 ("=" org-verbatim verbatim)
			 ("~" org-code verbatim)
			 ("+" (:strike-through t)))))

(require 'ox-reveal)

(provide 'setup-org)

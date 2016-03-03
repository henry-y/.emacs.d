(require 'org-mouse)

(setq org-todo-keywords
	  (quote ((sequence "TODO(t)" "MAYBE(m)" "PROJECT(p@)" "ONGOING(o!)" "WAIT(w@)" "|" "DONE(d!)" "CANCELLED(c@)"))))
(setq org-todo-keyword-faces
	  (quote (("TODO" :foreground "#ff0000" :weight bold)
			  ("MAYBE" :foreground "#ff4500" :weight bold)
			  ("PROJECT" :foreground "#0000ff" :weight bold)
			  ("DOING" :foreground "#b22222" :weight bold)
			  ("WAIT" :foreground "#ff8c00" :weight bold)
			  ("DONE" :foreground "#00ff00" :weight bold)
			  ("CANCELLED" :foreground "#7fff00" :weight bold))))
(setq org-use-fast-todo-selection t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)
(setq org-log-done 'note)
(setq org-log-into-drawer t)

(setq org-agenda-files (quote ("~/gtd/")))
(setq org-directory "~/gtd/org")
(setq org-default-notes-file "~/gtd/org/refile.org")
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/gtd/org/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/gtd/org/refile.org")
               "* TODO Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/gtd/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t))))

(setq org-clock-out-remove-zero-time-clocks t)

(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 9))))
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path t)

(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))
(setq org-refile-target-verify-function 'bh/verify-refile-target)

(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-agenda-dim-blocked-tasks nil)
(setq org-agenda-compact-blocks t)

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

(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)\\'" . org-mode))

(provide 'setup-org)

(require 'org-mouse)

(setq org-agenda-files (quote ("~/gtd/")))

(setq org-todo-keywords
	  (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
			  (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

(setq org-todo-keyword-faces
	  (quote (("TODO" :foreground "red" :weight bold)
			  ("NEXT" :foreground "blue" :weight bold)
			  ("DONE" :foreground "forest green" :weight bold)
			  ("WAITING" :foreground "orange" :weight bold)
			  ("HOLD" :foreground "magenta" :weight bold)
			  ("CANCELLED" :foreground "forest green" :weight bold))))

(setq org-use-fast-todo-selection t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-directory "~/gtd/org")
(setq org-default-notes-file "~/gtd/org/refile.org")
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/gtd/org/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/gtd/org/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/gtd/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/gtd/org/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/gtd/org/refile.org") 
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/gtd/org/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/gtd/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/gtd/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

(setq org-clock-out-remove-zero-time-clocks t)

(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 9))))
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path t)

(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

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

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(blink-cursor-mode 0)

(setq uniquify-min-dir-content 7)
(setq frame-title-format '("%b"))

(require 'vlf-setup)

(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000
	  hscroll-step 1
	  hscroll-margin 5)

(global-set-key (kbd "C->") '(lambda ()
								(interactive)
								(scroll-left 4)))
(global-set-key (kbd "C-<") '(lambda ()
								(interactive)
								(scroll-right 4)))

(column-number-mode t)

(size-indication-mode t)

(global-hl-line-mode +1)

(setq tab-width 4)

(require 'thing-edit)
(require 'thing-edit-extension)

(provide 'setup-editing)

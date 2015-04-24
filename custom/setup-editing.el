(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000)

(column-number-mode t)
(size-indication-mode t)

(global-hl-line-mode +1)

(setq tab-width 4)

(require 'thing-edit)
(require 'thing-edit-extension)

(provide 'setup-editing)

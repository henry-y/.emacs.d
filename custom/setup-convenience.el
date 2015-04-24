(fset 'yes-or-no-p 'y-or-n-p)

(windmove-default-keybindings)

(defun dired-back-to-top ()
  (interactive)
  (beginning-of-buffer)
  (dired-next-line 4))

(define-key dired-mode-map
  (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)

(defun dired-jump-to-bottom ()
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

(define-key dired-mode-map
    (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)

(defun smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))

  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line]
		'smarter-move-beginning-of-line)

(require 'undo-tree)
(global-undo-tree-mode)

(eval-after-load 'info
  '(progn (info-initialize)
	  (add-to-list 'Info-directory-list "~/.emacs.d/3rd/magit/")))
(require 'magit)

(global-set-key (kbd "<f5>") 'magit-status)
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")

(require 'multiple-cursors)

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".savedplaces" user-emacs-directory))

(require 'sr-speedbar)
(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Monaco-10")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

(require 'fullscreen)

(provide 'setup-convenience)

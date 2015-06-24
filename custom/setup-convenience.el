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

(require 'dired-tar)

(defun eshell-here ()
  "Opens up a new shell in the directory associated with the current buffer's file."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (name (car
                (last
                 (split-string parent "/" t)))))
    (split-window-vertically)
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))
    (insert (concat "ls"))
    (eshell-send-input)))
(global-set-key (kbd "C-!") 'eshell-here)

(defun eshell/x (&rest args)
  (kill-buffer-and-window))

(require 'desktop)
(require 'nameses)

(require 'ztree)

(provide 'setup-convenience)

(fset 'yes-or-no-p 'y-or-n-p)

(windmove-default-keybindings)

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

(add-to-list 'load-path "~/.emacs.d/3rd/git-modes")
(add-to-list 'load-path "~/.emacs.d/3rd/magit")
(eval-after-load 'info
  '(progn (info-initialize)
	  (add-to-list 'Info-directory-list "~/.emacs.d/3rd/magit/")))
(require 'magit)

(global-set-key (kbd "<f5>") 'magit-status)

(provide 'setup-convenience)

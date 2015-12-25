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

;; The following function only works with exactly two windows
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
			 (next-win-buffer (window-buffer (next-window)))
			 (this-win-edges (window-edges (selected-window)))
			 (next-win-edges (window-edges (next-window)))
			 (this-win-2nd (not (and (<= (car this-win-edges)
										 (car next-win-edges))
									 (<= (cadr this-win-edges)
										 (cadr next-win-edges)))))
			 (splitter
			  (if (= (car this-win-edges)
					 (car (window-edges (next-window))))
				  'split-window-horizontally
				'split-window-vertically)))
		(delete-other-windows)
		(let ((first-win (selected-window)))
		  (funcall splitter)
		  (if this-win-2nd (other-window 1))
		  (set-window-buffer (selected-window) this-win-buffer)
		  (set-window-buffer (next-window) next-win-buffer)
		  (select-window first-win)
		  (if this-win-2nd (other-window 1))))))

;; courtesy of http://emacswiki.org/emacs/ToggleWindowSplit

;; The following function works when there're more than 2 windows (besides the minibuffer window)
;; (defun window-toggle-split-direction ()
;;   "Switch window split from horizontally to vertically, or vice versa.

;; i.e. change right window to bottom, or change bottom window to right."
;;   (interactive)
;;   (require 'windmove)
;;   (let ((done))
;;     (dolist (dirs '((right . down) (down . right)))
;;       (unless done
;;         (let* ((win (selected-window))
;;                (nextdir (car dirs))
;;                (neighbour-dir (cdr dirs))
;;                (next-win (windmove-find-other-window nextdir win))
;;                (neighbour1 (windmove-find-other-window neighbour-dir win))
;;                (neighbour2 (if next-win (with-selected-window next-win
;;                                           (windmove-find-other-window neighbour-dir next-win)))))
;;           ;;(message "win: %s\nnext-win: %s\nneighbour1: %s\nneighbour2:%s" win next-win neighbour1 neighbour2)
;;           (setq done (and (eq neighbour1 neighbour2)
;;                           (not (eq (minibuffer-window) next-win))))
;;           (if done
;;               (let* ((other-buf (window-buffer next-win)))
;;                 (delete-window next-win)
;;                 (if (eq nextdir 'right)
;;                     (split-window-vertically)
;;                   (split-window-horizontally))
;;                 (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))

(define-key ctl-x-4-map "t" 'toggle-window-split)

(require 'desktop)
(require 'nameses)
(require 'ztree)
(require 'wgrep)

(require 'beacon)
(beacon-mode 1)

(provide 'setup-convenience)

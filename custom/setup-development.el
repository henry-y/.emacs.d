(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(meta f3)] 'highlight-symbol-prev)
(global-set-key [(control meta f3)] 'highlight-symbol-query-replace)

(defun my-prog-mode-hook()
  (linum-mode t)
  (highlight-numbers-mode t)
  (highlight-parentheses-mode t))
(add-hook 'prog-mode-hook 'my-prog-mode-hook)

(electric-pair-mode t)

(require 'ycmd)
(ycmd-setup)
(set-variable 'ycmd-server-command '("python" "/root/dev/ycmd/ycmd"))

(require 'company)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.2)
(setq company-show-numbers t)
(setq company-backends '(company-clang company-gtags company-files))
;; (global-set-key "\t" 'company-complete)
(add-hook 'after-init-hook 'global-company-mode)

(require 'company-ycmd)
(company-ycmd-setup)

(which-function-mode t)
(setq mode-line-misc-info (delete (assoc 'which-func-mode
					 mode-line-misc-info) mode-line-misc-info)
      which-func-header-line-format '(which-func-mode ("" which-func-format)))
(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (setq mode-line-misc-info (delete (assoc which-func-mode
					     mode-line-misc-info) mode-line-misc-info)
	  header-line-format which-func-header-line-format)))

(setq c-default-style "linux"
      c-basic-offset 4)

(defun my-c-mode-hook()
  (setq-default indent-tabs-mode nil))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(require 'font-lock)

(defface font-lock-function-call-face
  '((t (:foreground "#AA5533" :bold t)))
  "Font Lock mode face used to highlight function calls."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-function-call-face 'font-lock-function-call-face)

(font-lock-add-keywords
 'c-mode
 '(("\\(\\w+\\)\\s-*\(" 1 'font-lock-function-call-face))
 '(("\\<\\(if\\|while\\)\\s-*\(" 1 'font-lock-keyword-face)))

(require 'flycheck)
(setq flycheck-display-errors-function nil)
(add-hook 'after-init-hook #'global-flycheck-mode)
;; (require 'flycheck-tip)
;; (flycheck-tip-use-timer 'verbose)

(setq
 gdb-many-windows t
 gdb-show-main t
  )       

;;stolen from http://everet.org/customize-emacs-gud-many-windows.html
(defadvice gdb-setup-windows (after my-setup-gdb-windows activate)
  "my gdb UI"
  (gdb-get-buffer-create 'gdb-stack-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (let ((win0 (selected-window))
	(win1 (split-window nil nil 'left))      ;code and output
	(win2 (split-window-below (/ (* (window-height) 2) 3)))     ;stack
	)
    (select-window win2)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (select-window win1)
    (set-window-buffer
     win1
     (if gud-last-last-frame
	 (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
	   (gud-find-file gdb-main-file)
	 ;; Put buffer list in window if we
	 ;; can't find a source file.
	 (list-buffers-noselect))))
    (setq gdb-source-window (selected-window))
    (let ((win3 (split-window nil (/ (* (window-height) 3) 4)))) ;io
      (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-inferior-io) nil win3))
    (select-window win0)
        ))           

(provide 'setup-development)

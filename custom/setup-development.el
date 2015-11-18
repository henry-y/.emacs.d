(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(meta f3)] 'highlight-symbol-prev)
(global-set-key [(control meta f3)] 'highlight-symbol-query-replace)

(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#e3e3d3")
(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

(defun my-prog-mode-hook()
  (linum-mode t)
  (highlight-numbers-mode t)
  (highlight-parentheses-mode t)
  (setq web-mode-html-offset 2) ;;fix web-mode
  (highlight-indentation-mode t)
  (setq tab-width 4)
  (defvaralias 'c-basic-offset 'tab-width)
  (defvaralias 'cperl-indent-level 'tab-width))
(add-hook 'prog-mode-hook 'my-prog-mode-hook)

(electric-pair-mode t)

(require 'ycmd)
(ycmd-setup)
(set-variable 'ycmd-server-command '("python" "/root/.emacs.d/3rd/ycmd/ycmd"))

(require 'company)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.2)
(setq company-show-numbers t)
(setq company-selection-wrap-around t)
;; (setq company-backends '(company-clang company-gtags company-files))
;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "TAB") 'company-select-next)
;;      (define-key company-active-map [tab] #'company-select-next)))
(setq company-dabbrev-downcase nil)

(defun company-complete-common-or-cycle ()
  (interactive)
  (when (company-manual-begin)
    (if (eq last-command 'company-complete-common-or-cycle)
        (let ((company-selection-wrap-around t))
          (call-interactively 'company-select-next))
      (call-interactively 'company-complete-common))))
(define-key company-active-map [tab] 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)

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

(c-set-offset 'inline-open '0)

(defun my-c-mode-hook()
  (setq-default indent-tabs-mode nil))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(require 'font-lock)

(defface font-lock-function-call-face
  '((t (:foreground "#FF0000")))
  "Font Lock mode face used to highlight function calls."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-function-call-face 'font-lock-function-call-face)

(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\(\\w+\\)\\s-*\(" 1 'font-lock-function-call-face))
                                    '(("\\<\\(if\\|while\\)\\s-*\(" 1 'font-lock-keyword-face)))))

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

(setq rtags-src-dir
      (expand-file-name "3rd/rtags/src" user-emacs-directory))
(add-to-list 'load-path rtags-src-dir)
(require 'rtags)

(define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key c-mode-base-map (kbd "M-]") 'rtags-find-references-at-point)
(define-key c-mode-base-map (kbd "M-*") 'rtags-location-stack-back)
(define-key c-mode-base-map (kbd "M-(") 'rtags-location-stack-forward)
(define-key c-mode-base-map (kbd "<M-up>") 'rtags-previous-match)
(define-key c-mode-base-map (kbd "<M-down>") 'rtags-next-match)
(define-key c-mode-base-map (kbd "C-c h i") 'rtags-imenu)

(require 'hideshow)
(require 'sgml-mode)
(require 'nxml-mode)
(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>"
               "-->\\|</[^/>]*[^/]>"

               "<!--"
               sgml-skip-tag-forward
               nil))
(defun my-nxml-mode-hook()
  (setq-default indent-tabs-mode nil)
  (setq nxml-child-indent 4)
  (setq nxml-slash-auto-complete-flag t)
  (hs-minor-mode))
(add-hook 'nxml-mode-hook 'my-nxml-mode-hook)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))

(defun my-web-mode-indent (n)
  (setq web-mode-markup-indent-offset n)
  (setq web-mode-css-indent-offset n)
  (setq web-mode-code-indent-offset n))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (my-web-mode-indent 2)
  ;; (define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
  (setq web-mode-enable-current-element-highlight t))
  ;; (setq web-mode-enable-current-column-highlight t))
(add-hook 'web-mode-hook 'my-web-mode-hook)

(require 'projectile)
(projectile-global-mode)
(require 'helm-projectile)
(helm-projectile-on)

(provide 'setup-development)

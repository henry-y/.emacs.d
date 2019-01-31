;; minimal config
;; org, helm, company, undo-tree, anaconda-mode, company-anaconda, beacon, web-mode, flycheck
;; JSHint

;;******************** package ********************;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa". "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(when (string-equal system-type "windows-nt")
  (let (
	(mypaths
	 '(
	   "C:/cygwin64/usr/local/bin"
	   "C:/cygwin64/bin"
	   "C:/Python27"
	   "C:/Python27/Scripts"
	   ))
	)
    (setenv "PATH" (mapconcat 'identity mypaths ";"))
    (setq exec-path (append mypaths (list "." exec-directory)))
    ))

;;******************** anaconda mode ********************;;
;;need to do "pip install service_factory"
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(defun my-anaconda-hook()
  (define-key anaconda-mode-map (kbd "M-]") 'anaconda-mode-find-references)
  (define-key anaconda-mode-map (kbd "M-*") 'xref-pop-marker-stack))
(add-hook 'anaconda-mode-hook 'my-anaconda-hook)
;; *scratch*
;; (add-to-list 'python-shell-extra-pythonpaths "/path/to/the/project")
;; (add-to-list 'python-shell-extra-pythonpaths "/path/to/the/dependency")

;;******************** graphviz-dot-mode ********************;;
(defun my-graphviz-hook()
  (setq graphviz-dot-auto-indent-on-braces t
        graphviz-dot-indent-width 4))
(add-hook 'graphviz-dot-mode-hook 'my-graphviz-hook)

;;******************** emacs intrinsic ********************;;
(setq inhibit-startup-screen t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000
	  hscroll-step 1
	  hscroll-margin 5)

(fset 'yes-or-no-p 'y-or-n-p)

(windmove-default-keybindings)

(blink-cursor-mode 0)

;;linum mode conflict with pdf-tools
;;(global-linum-mode t)

(setq line-number-display-limit-width 2000000)

(size-indication-mode t)

(save-place-mode 1)

(global-set-key (kbd "C->") '(lambda ()
			       (interactive)
			       (scroll-left 4)))
(global-set-key (kbd "C-<") '(lambda ()
			       (interactive)
			       (scroll-right 4)))

(setq-default truncate-lines t)

(which-function-mode t)
(setq mode-line-misc-info (delete (assoc 'which-func-mode
					 mode-line-misc-info) mode-line-misc-info)
      which-func-header-line-format '(which-func-mode ("" which-func-format)))
(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (setq mode-line-misc-info (delete (assoc which-func-mode
					     mode-line-misc-info) mode-line-misc-info)
	  header-line-format which-func-header-line-format)))

(setq frame-title-format "%b (%f)")

(setq-default indent-tabs-mode nil)

(electric-pair-mode t)

(defalias 'perl-mode 'cperl-mode)
(setq cperl-invalid-face nil
      cperl-close-paren-offset -2
      cperl-indent-parens-as-block t) 

;;******************** org ********************;;

;;******************** helm ********************;;
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(define-key helm-command-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-command-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-command-map (kbd "C-z") 'helm-select-action)

(setq helm-split-window-in-side-p t
      helm-buffers-fuzzy-matching t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-scroll-amount 8
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
;; (when (executable-find "ack-grep")
;;   (setq helm-grep-default-command "ack-grep -nH --no-group --no-color %e %p %f"
;; 	helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
(setq helm-grep-default-command
	  "grep --color=always -d skip %e -n%cH -e %p %f"
	  helm-grep-default-recurse-command
	  "grep --color=always -d recurse %e -n%cH -e %p %f")

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
(global-set-key (kbd "C-c <SPC>") 'helm-global-mark-ring)

;;******************** company ********************;;

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

;;******************** company anaconda ********************;;
;; (eval-after-load "company"
;;   '(add-to-list 'company-backends 'company-anaconda))
(eval-after-load "company"
  '(add-to-list 'company-backends '(company-anaconda :with company-capf)))

;;******************** undo-tree ********************;;

(require 'undo-tree)
(global-undo-tree-mode)

;;******************** beacon ********************;;
(beacon-mode 1)

;;******************** web-mode ********************;;
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
(add-to-list 'auto-mode-alist '("\\.handlebars?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json?\\'" . web-mode))

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

;;******************** flycheck ********************;;
;; (global-flycheck-mode)

;;******************** fonts ********************;;
;;(defun my-set-font (english chinese english-size chinese-size)
;;  (set-face-attribute 'default nil :font
;;                      (format   "%s:pixelsize=%d"  english english-size))
;;  (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;    (set-fontset-font (frame-parameter nil 'font) charset
;;                      (font-spec :family chinese :size chinese-size))))
;;(my-set-font "Anonymous Pro" "Microsoft Yahei" 15 16)

;;******************** deft ********************;;
(setq deft-directory "~/Nextcloud/yh/documents/note")
(setq deft-extensions '("md" "org"))
(setq deft-use-filename-as-title nil)
(setq deft-use-filter-string-for-filename t)
(setq deft-file-naming-rules
      '((noslash . "_")
        (nospace . "_")
        (case-fn . downcase)))
(setq deft-markdown-mode-title-level 1)

(defun deft-search(filter)
  (interactive "MFilter: ")
  (deft)
  (deft-filter filter t)
  )


;;******************** markdown mode ********************;;
(setq markdown-command "~/anaconda3/bin/pandoc")

(pdf-tools-install)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (wgrep-ag deft helm-ag ag ess edit-indirect graphviz-dot-mode pdf-tools markdown-mode magit flycheck web-mode company-anaconda beacon undo-tree org helm company anaconda-mode))))

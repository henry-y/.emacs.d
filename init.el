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
	   ))
	)
    (setenv "PATH" (mapconcat 'identity mypaths ";"))
    (setq exec-path (append mypaths (list "." exec-directory)))
    ))

;; (setq url-using-proxy t)
;; (setq url-proxy-services '(("http" . "__proxy_url__")))

(setq inhibit-startup-screen t)

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq custom-dir
      (expand-file-name "custom" user-emacs-directory))
(add-to-list 'load-path custom-dir)

(setq 3rd-dir
      (expand-file-name "3rd" user-emacs-directory))
(dolist (project (directory-files 3rd-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(setq no-repo
      (expand-file-name "3rd/no-repo" user-emacs-directory))
(dolist (project (directory-files no-repo t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(require 'setup-helm)
(require 'dcpl-mode)
(require 'setup-development)
(require 'setup-python)
(require 'setup-convenience)
(require 'setup-onekey)
(require 'setup-editing)
(require 'setup-org)
(require 'setup-org-publish-html)
(require 'setup-twiki)
(require 'setup-sauron)
(require 'setup-mu4e)
(require 'setup-log)
(require 'setup-tool)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-global-modes (quote (not eshell-mode)))
 '(custom-enabled-themes (quote (leuven)))
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style (quote relative))
 '(truncate-lines t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-local-file-without-region ((t (:foreground "color-46"))))
 '(web-mode-current-column-highlight-face ((t (:background "#cfead6"))))
 '(web-mode-current-element-highlight-face ((t (:background "#cfead6"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#ba722a"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "#4477c9"))))
 '(web-mode-html-tag-face ((t (:foreground "#4477c9"))))
 '(which-func ((t (:foreground "brightred" :weight bold)))))

;; (setq debug-on-error t)

;; use anonymous pro font http://www.marksimonson.com/fonts/view/anonymous-pro
(add-to-list 'default-frame-alist '(font . "Anonymous Pro"))

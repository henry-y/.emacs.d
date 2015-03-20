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

(add-to-list 'load-path "~/.emacs.d/custom/")

(require 'setup-helm)
(require 'setup-development)
(require 'setup-convenience)
(require 'setup-editing)
(require 'setup-org)
(require 'setup-org-publish-html)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (leuven)))
 '(org-html-head "")
 '(org-html-table-default-attributes
   (quote
    (:class "table table-bordered table-hover table-condensed"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-local-file-without-region ((t (:foreground "color-46"))))
 '(which-func ((t (:foreground "brightred" :weight bold)))))

;; (setq debug-on-error t)

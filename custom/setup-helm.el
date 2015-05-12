(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

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
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -nH --no-group --no-color %e %p %f"
	helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
(global-set-key (kbd "C-c <SPC>") 'helm-global-mark-ring)

(require 'helm-gtags)

;; (add-hook 'c-mode-hook 'helm-gtags-mode)
;; (add-hook 'c++-mode-hook 'helm-gtags-mode)
;; (add-hook 'asm-mode-hook 'helm-gtags-mode)
;; (add-hook 'dcpl-mode-hook 'helm-gtags-mode)

(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t))

(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-]") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-*") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "M-(") 'helm-gtags-next-history)))

(helm-autoresize-mode 1)

(require 'helm-swoop)
(global-set-key (kbd "C-c h o") 'helm-swoop)

(provide 'setup-helm)

;; (require 'python-mode)

;; (setq-default py-shell-name "ipython")
;; (setq-default py-which-bufname "IPython")
;; (setq py-python-command-args
;; 	  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
;; (setq py-force-py-shell-name-p t)

;; (setq py-switch-buffers-on-execute-p t)
;; (setq py-smart-indentation t)

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

(require 'elpy)
(elpy-enable)

(provide 'setup-python)

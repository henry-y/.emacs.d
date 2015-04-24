(require 'one-key)

;; NOT WORKING???
;; (defvar one-key-menu-root-alist nil
;;   "The `one-key-mode' menu alist for root.")

;; (setq one-key-menu-root-alist
;;       '(
;;         (("o" . "Open Directory") . one-key-menu-directory)
;;         (("e" . "Edit") . one-key-menu-thing-edit)
;;         ))

;; (defun one-key-menu-root()
;;   "The `one-key-mode' menu for root."
;;   (interactive)
;;   (one-key-menu "ROOT" one-key-menu-root-alist))

(defvar one-key-menu-directory-alist nil
  "The `one-key-mode' menu alist for DIRECTORY.")

(defvar my-home-directory "~")
(defvar my-emacs-directory "~/.emacs.d/")

(setq one-key-menu-directory-alist
      '(
        (("h" . "Home") . (lambda () (interactive) (dired-x-find-file my-home-directory)))
        (("e" . "Emacs") . (lambda () (interactive) (dired-x-find-file my-emacs-directory)))
        ))

(defun one-key-menu-directory ()
  "The `one-key-mode' menu for DIRECTORY."
  (interactive)
  (one-key-menu "DIRECTORY" one-key-menu-directory-alist t))

(defvar one-key-menu-thing-edit-alist nil
  "The `one-key-mode' menu alist for THING-EDIT.")

(setq one-key-menu-thing-edit-alist
      '(
        ;; Copy
        (("w" . "Copy Word") . thing-copy-word)
        (("s" . "Copy Symbol") . thing-copy-symbol)
        (("l" . "Copy Line") . thing-copy-line)
        (("p" . "Copy Parentheses") . thing-copy-parentheses)
        (("f" . "Copy Function") . thing-copy-defun)
        ;; Cut
        (("W" . "Cut Word") . thing-paste-word)
        (("S" . "Cut Symbol") . thing-paste-symbol)
        (("L" . "Cut Line") . thing-paste-line)
        (("P" . "Cut Parentheses") . thing-paste-parentheses)
        (("F" . "Cut Function") . thing-paste-defun)
        ))

(defun one-key-menu-thing-edit ()
  "The `one-key-mode' menu for THING-EDIT."
  (interactive)
  (one-key-menu "THING-EDIT" one-key-menu-thing-edit-alist t))

(global-set-key (kbd "C-c d") 'one-key-menu-directory)
(global-set-key (kbd "C-c e") 'one-key-menu-thing-edit)

(provide 'setup-onekey)

(require 'smtpmail)

(setq mu4e-dir "/usr/local/share/emacs/site-lisp/mu4e")
(add-to-list 'load-path mu4e-dir)
(require 'mu4e)

(setq mu4e-maildir "~/mail"
      mu4e-drafts-folder "/Drafts"
      mu4e-sent-folder "/Sent"
      mu4e-trash-folder "/Trash")

(setq mu4e-sent-messages-behavior 'delete)

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"           . ?i)
	 ("/Sent"            . ?s)
         ("/Drafts"          . ?d)
	 ("/Trash"           . ?t)))

(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 300
      mu4e-headers-auto-update t)

(setq mu4e-split-view 'vertical)
(setq mu4e-headers-visible-columns 110)
(setq mu4e-headers-fields
      '((:date    .   12)
	(:flags   .    5)
	(:from    .   20)
	(:subject .  nil)))
(setq mu4e-view-scroll-to-next nil)
(setq mu4e-view-show-images t)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
(setq mu4e-view-prefer-html t)
;; (require 'mu4e-contrib)
;; (setq mu4e-html2text-command 'mu4e-shr2text)
(defun my-render-html-message ()
  (let ((dom (libxml-parse-html-region (point-min) (point-max))))
    (erase-buffer)
    (shr-insert-document dom)
    (goto-char (point-min))))
(setq mu4e-html2text-command 'my-render-html-message)

(add-hook 'mu4e-compose-mode-hook
          (defun my-do-compose-stuff ()
            "My settings for message composition."
            (flyspell-mode)
	    ;; this override the org config, fix TODO
	    (set 'org-html-table-header-tags '("<th scope=\"%s\"%s style=\"text-align:left\">" . "</th>"))
	    (set 'org-html-table-default-attributes '(:border "1" :cellpadding "6" :cellspacing "0" :style "border-collapse:collapse;text-align:left"))))

;; experimental???
;; org~mu4e-mime-switch-headers-or-body then C-c C-c at header
(require 'org-mu4e)
(setq org-mu4e-convert-to-html t)

(setq
 user-mail-address "henry.yin@nokia.com"
 user-full-name "Henry Yin"
 message-signature
 (concat
  "Best wishes\n"
  "Henry Yin\n"
  "\n"))

(setq mu4e-compose-signature message-signature)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'plain
      smtpmail-default-smtp-server "localhost"
      smtpmail-smtp-server "localhost"
      smtpmail-smtp-service 1025)

(provide 'setup-mu4e)

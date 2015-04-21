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
      '( ("/INBOX"            . ?i)
	 ("/Sent"            . ?s)
         ("/Drafts"          . ?d)
	 ("/Trash"           . ?t)))

(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 300
      mu4e-headers-auto-update t)

(setq mu4e-view-scroll-to-next nil)
(setq mu4e-view-show-images t)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
(setq mu4e-view-prefer-html t)
(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)

(add-hook 'mu4e-compose-mode-hook
          (defun my-do-compose-stuff ()
            "My settings for message composition."
            (flyspell-mode)))

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

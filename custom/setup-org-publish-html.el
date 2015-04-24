(require 'ox-publish)

(setq org-html-head "")
(setq org-html-table-default-attributes '(:class "table table-bordered table-hover table-condensed"))
(setq org-export-with-toc nil)
(setq org-publish-use-timestamps-flag nil)
;(setq org-html-htmlize-output-type 'css)

(setq org-publish-project-alist
      '(
	
	("org-jekyll-blogs"
	 :base-directory "~/blog/"
	 :base-extension "org"
	 :publishing-directory "~/henry-y.github.io/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 6
	 :section-numbers nil
	 :html-extension "html"
	 :body-only t
         :style-include-default nil
         )

	("org-jekyll-static"
	 :base-directory "~/blog/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/henry-y.github.io/"
	 :recursive t
	 :publishing-function org-publish-attachment)

	("org-jekyll"
	 :components ("org-jekyll-blogs" "org-jekyll-static"))
	))

;; Improve our blogging experience with Org. This code sets four functions with
;; corresponding key bindings:
;;
;; C-c j n - Create new draft
;; C-c j p - Post current draft
;; C-c j d - show all drafts
;; C-c j l - Show all posts
;;
;; Once a draft has been posted (i.e., moved from the _drafts
;; directory to _posts with the required date prefix in the filename),
;; we then need to html-export it to the jekyll rootdir (with org-publish).

(global-set-key (kbd "C-c j n") 'jekyll-draft-post)
(global-set-key (kbd "C-c j p") 'jekyll-publish-post)
(global-set-key (kbd "C-c j l") (lambda ()
				  (interactive)
				  (find-file "~/blog/_posts/")))
(global-set-key (kbd "C-c j d") (lambda ()
				  (interactive)
				  (find-file "~/blog/_drafts/")))

(defvar jekyll-directory "~/blog/"
  "Path to Jekyll Org blog.")
(defvar jekyll-drafts-dir "_drafts/"
  "Relative path to drafts directory.")
(defvar jekyll-posts-dir "_posts/"
  "Relative path to posts directory.")
(defvar jekyll-post-ext ".org"
  "File extension of Jekyll posts.")
(defvar jekyll-post-template
  "#+STARTUP: showall\n#+STARTUP: hidestars\n#+OPTIONS: H:2 num:nil tags:nil toc:0 ^:nil timestamps:t\n#+BEGIN_HTML\n---\nlayout: post\ntitle: %s\nexcerpt: \ndate: \ncategories:\ntags:\npublished: true\n---\n#+END_HTML\n#+TOC: headlines 2\n\n"
  "Default template for Jekyll posts. %s will be replace by the post title.")

(defun jekyll-update-date ()
  "Update the YAML date element to the current time."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (search-forward-regexp "^date:")
    (kill-whole-line)
    (insert (concat "date: " (format-time-string "%Y-%m-%dT%H:%M:%SZ\n" nil t)))))
(defun jekyll-make-slug (s)
  "Turn a string into a slug."
  (replace-regexp-in-string
   " " "-" (downcase
	    (replace-regexp-in-string
	     "[^A-Za-z0-9 ]" "" s))))
(defun jekyll-yaml-escape (s)
  "Escape a string for YAML."
  (if (or (string-match ":" s)
	  (string-match "\"" s))
      (concat "\"" (replace-regexp-in-string "\"" "\\\\\"" s) "\"")
    s))
(defun jekyll-draft-post (title)
  "Create a new Jekyll blog post."
  (interactive "sPost Title: ")
  (let ((draft-file (concat jekyll-directory jekyll-drafts-dir
			    (jekyll-make-slug title)
			    jekyll-post-ext)))
    (if (file-exists-p draft-file)
	(find-file draft-file)
      (find-file draft-file)
      (insert (format jekyll-post-template (jekyll-yaml-escape title))))))
(defun jekyll-publish-post ()
  "Move a draft post to the posts directory, and rename it so that it
contains the date."
  (interactive)
  (cond
   ((not (equal
	  (file-name-directory (buffer-file-name (current-buffer)))
	  (expand-file-name (concat jekyll-directory jekyll-drafts-dir))))
    (message "This is not a draft post.")
    (insert (file-name-directory (buffer-file-name (current-buffer))) "\n"
	   (expand-file-name (concat jekyll-directory jekyll-drafts-dir))))
   ((buffer-modified-p)
    (message "Can't publish post; buffer has modifications."))
   (t
    (let ((filename
	   (concat jekyll-directory jekyll-posts-dir
		   (format-time-string "%Y-%m-%d-")
		   (file-name-nondirectory
		    (buffer-file-name (current-buffer)))))
	  (old-point (point)))
      (rename-file (buffer-file-name (current-buffer))
		   filename)
      (kill-buffer nil)
      (find-file filename)
      (set-window-point (selected-window) old-point)))))

(provide 'setup-org-publish-html)


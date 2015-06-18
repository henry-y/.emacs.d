#Abstract

This is my emacs configuration. It keeps updating, so drop by while you're free.

#Requirements

Recent Emacs is needed, at least Emacs-24.4. Installation steps of Emacs 24.4 can be found at [my blog:Emacs Tutorial](http://henry-y.github.io/2015/01/emacs-tutorial/)

# Getting Started

1. **Make sure there's no Emacs init file by removing ~/.emacs, ~/.emacs.el and ~/.emacs.d**
2. Clone the repository to ~/.emacs.d
3. Fetch all submodules:
	`git submodule update --init --recursive`
	(_this may take some time depending on download speed._)
4. Make helm:
	```
	cd 3rd/helm
	make
	```
5. Make Pymacs:
	```
	cd 3rd/Pymacs
	make
	python setup.py install
	```
6. Make ropemacs:
	```
	cd 3rd/ropemacs
	python setup.py install
	```
7. Follow the instructions at [my blog:Emacs for Email](http://henry-y.github.io/2015/04/emacs-for-email/) to configure mu
	(_if you don't want to use email with Emacs, skip this step and comment out `(require 'setup-mu4e)` in ~/.emacs.d/init.el_)

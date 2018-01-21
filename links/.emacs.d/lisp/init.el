;; add modules directory to load-path
(add-to-list 'load-path "~/.emacs.d/modules/")

;; highlight matching closing brackets
(show-paren-mode 1)

;; insert closing brackets automagically
;(electric-pair-mode 1)

;; set scroll step as 1 line
(setq-default scroll-step 1)

;; show line number on the left of file contents
;(global-linum-mode 1)

;; disable tabs when auto-indenting (only uses spaces)
(setq-default indent-tabs-mode nil)

;; display line and column number in the bottom bar
(line-number-mode 1)
(column-number-mode 1)

;; highlight trailing spaces/tabs as also empty lines at start/end
;; of document and lines longer than whitespace-line-num (80 by default)
(setq-default whitespace-style '(face lines-tail empty trailing))
(global-whitespace-mode 1)

;; loads external git-bundled git module
;(require 'git)

;; set backup files directory and don't ask for deletion of older files
(setq-default
  backup-by-copying 1 ;; don't clobber symlinks
  backup-directory-alist '(("." . "~/.emacs.d/backups/"))
  delete-old-versions t
  version-control t) ;; use versioned backups

;; load solarized dark theme
;(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
;(load-theme 'solarized-dark t)

;; add MELPA packages repo
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Custome function for stuff to do when python-mode is invoked
;(defun my-python-mode()
;  (setq whitespace-style '(face lines empty trailing)))
;
;; Add hooks
;(add-hook 'python-mode-hook 'my-python-mode)

;; Enable flycheck when in python-mode
;(add-hook 'python-mode-hook #'global-flycheck-mode)
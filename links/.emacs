;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; append-tuareg.el - Tuareg quick installation: Append this file to .emacs.
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq emacs-lisp-dir "~/.emacs.d/"
      my-elmode-dir (concat emacs-lisp-dir "elmodes/"))
(setq load-path
      (append load-path (list my-elmode-dir)))

(add-to-list 'load-path "~/.emacs.d/lisp")

;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'Renaud t)

(load "std.el")
(load "std_comment.el")
(if (file-exists-p "~/.myemacs")
    (load-file "~/.myemacs"))
(put 'upcase-region 'disabled nil)

(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(dolist (ext '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi"))
  (add-to-list 'completion-ignored-extensions ext))

;; Nice Linum
(dolist (hook '(python-mode-hook
		c-mode-common-hook
		php-mode-hook
		sh-mode-hook
		emacs-list-mode-hook))
  (add-hook hook (lambda () (linum-mode t) (setq linum-format "%3d |"))))
(setq linum-format "%3d |")
;\u2502

;; Ask y/n instead yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Featured switch-to-buffer
(iswitchb-mode t)

;;Pour changer facilement de buffer
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;;parentheses
(show-paren-mode)

;; molette souris
(mouse-wheel-mode t)

;;colonnes
(setq column-number-mode t)

;;surbrillance de la region
(setq transient-mark-mode t)

;;affiche les espaces inutile
(setq-default show-trailing-whitespace t)

;; Clear whitespaces
;(define-key text-mode-map (kbd "<f8>") 'delete-trailing-whitespace)
(global-set-key (kbd "<f8>") 'delete-trailing-whitespace)

;; Replace
(global-set-key (kbd "<f7>") 'query-replace-regexp)

;; Linum-mode
(global-set-key (kbd "<f6>") 'linum-mode)

;; Disable unusual bars
;(scroll-bar-mode -1)
;(menu-bar-mode -1)
;(tool-bar-mode -1)

;;couleur en mode shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun to-bottom () (interactive) "Recenter screen so that current
line is on the bottom of the screen"
  (recenter -1)
  )
(defun set-key-to-bottom () (interactive)
  (local-set-key "\C-l" 'to-bottom)
  )
(add-hook 'shell-mode-hook 'set-key-to-bottom)

;; Whitespaces
(require 'whitespace)
;(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face empty lines-tail trailing))
(global-whitespace-mode t)

;; Show tabs and too long lines


(defun cc-mode-add-keywords (mode)
  (font-lock-add-keywords
   mode
   '(
     ("\t+" (0 'my-tab-face append))
     ("^.\\{81\\}\\(.+\\)$" (1 'my-loong-line-face append)))))

(cc-mode-add-keywords 'c-mode)
(cc-mode-add-keywords 'php-mode)
(cc-mode-add-keywords 'sh-mode)
(cc-mode-add-keywords 'python-mode)
(cc-mode-add-keywords 'perl-mode)
(cc-mode-add-keywords 'c++-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (Renaud)))
 '(custom-safe-themes
   (quote
    ("0e2b89ff50b40813ef867e6f60911a2c4a9e14e72cc56b33cf370c2892eb2c0e" "530c7b66006825d2c9923416c63c4b590d68eaae35bddbdf80212210e32c7e91" "f146cf0feba4fed38730de65e924e26140b470a4d503287e9ddcf7cca0b5b3f0" default)))
 '(delete-selection-mode nil)
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (sokoban))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-string-face ((t (:foreground "green"))))
 '(highlight ((t (:weight bold))))
 '(my-loong-line-face ((((class color)) (:background "yellow"))) t)
 '(my-tab-face ((((class color)) (:foreground "black" :weight bold :underline t))) t))

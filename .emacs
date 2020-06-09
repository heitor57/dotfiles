(require 'package)
(package-initialize)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist
	     '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(font . "Hack 10"))

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(use-package openwith
  :config
  (setq openwith-associations '(("\\.pdf\\'" "zathura" (file))
					;("\\.html\\'" "firefox" (file))
				;; ("\\.png\\'" "sxiv" (file))
				;; ("\\.jpg\\'" "sxiv" (file))
				))
  (openwith-mode t)
  )

(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

(use-package evil
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "<f5>") 'save-some-buffers)
  (define-key evil-normal-state-map (kbd "<f6>") 'revert-buffer-no-confirm)

  (define-key evil-normal-state-map (kbd "z 1") 'org-latex-export-to-pdf)
  (define-key evil-normal-state-map (kbd "z 2")
    (lambda () (interactive)
      (call-process-shell-command
       (concat "zathura " (file-name-base) ".pdf") nil 0)))
  )

(use-package magit)
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner nil)
  (setq dashboard-items '((recents  . 13)
			  (bookmarks . 5)
			  (projects . 8)
			  (agenda . 8)
			  (registers . 5)))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))

(use-package company
  :config
  (setq company-idle-delay 0)
  (add-hook 'after-init-hook 'global-company-mode))

(defun dired-connect-ssh (user ip)
  (interactive "sUser name:\nsIp to connect:")
  (find-file (concat "/ssh:" user "@" ip ":~")))

(setq dired-listing-switches "-alh")

(use-package hydra
  :bind
  ("C-c c" . hydra-ssh/body)
  :config
  (defhydra hydra-ssh (:color blue)
    "Connect"
    ("d" (dired-connect-ssh "heitor" "200.17.66.6") "duff")
    ("t" (dired-connect-ssh "heitor" "200.17.66.5") "tesla")
    ("r" (dired-connect-ssh "heitor" "200.17.66.4") "ralph")
    ("e" (dired-connect-ssh "heitor" "172.18.0.216") "Iduff")))

(use-package helm-smex
  :config
  (global-set-key (kbd "M-x") #'helm-smex)
  (global-set-key (kbd "M-X") #'helm-smex-major-mode-commands))

(defun auto-rerun-sxhkd ()
  "Used in `after-save-hook', sxhkd helper."
  (when (or (equal buffer-file-name "/home/heitor/.config/sxhkd/sxhkdrc") (equal buffer-file-name "/home/heitor/dotfiles/.config/sxhkd/sxhkdrc"))
    (call-process-shell-command
     (concat "killall sxhkd; setsid sxhkd") nil 0)))

(add-hook 'after-save-hook 'auto-rerun-sxhkd)
(setq dired-dwim-target t)

(use-package org
  :config
  (setq org-startup-truncated nil)
  (setq org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex -interaction nonstopmode -output-diretory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f"))
  (setq org-latex-prefer-user-labels 1))


(use-package org-ref)
(use-package auctex)
(use-package ein)

(use-package projectile
  :config
  (projectile-mode +1)
  ;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (define-key evil-normal-state-map (kbd "z p") 'projectile-command-map)
  )
(use-package helm-bibtex
  :config
  (setq bibtex-completion-bibliography
	'("~/Dropbox/RecSys2020SurveyPOIs/Apoio/doc.bib"
	  ;; "~/Dropbox/RecSys2020SurveyPOIs/v02/recsys20.bib"
	  ))
  )
(use-package helm-ag
  :config
  (define-key evil-normal-state-map (kbd "f a") 'helm-ag)
  )

;; (use-package dracula-theme)
;; (use-package minsk-theme)
;; (require 'google-translate)




;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/google-translate/"))
;; (message (expand-file-name "~/.emacs.d/google-translate/"))
;; (load "google-translate")
;; (setq google-translate-translation-directions-alist '(("en" . "pt")))
;; (require 'google-translate)

;; (load "~/.emacs.d/google-translate/google-translate.el")
(use-package google-translate
 :init (setq google-translate-translation-directions-alist '(("en" . "pt")))
 :config
 (setq google-translate-backend-method 'curl)
 ;; ;; (setq google-translate-backend-method 'curl)
 ;; (require 'google-translate-smooth-ui)
 (setq google-translate-output-destination nil)
 :bind (("\C-ct" . google-translate-smooth-translate))
 )
;(google-translate-smooth-translate "ewqewqe")
;; hello world

;(set-frame-font "Fira Code" nil t)
;; (global-hl-line-mode 1)
;; (set-face-attribute 'hl-line nil :inherit nil :background "gray7")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-ref-pdf-directory "~/Downloads/")
 '(package-selected-packages
   (quote
    (minsk-theme modus-vivendi-theme auctex django-mode company-mode yaml-mode web-mode use-package solarized-theme ranger projectile poly-markdown org-ref org-bullets openwith nimbus-theme neotree moe-theme mips-mode magit lua-mode kaolin-themes impatient-mode iedit helm-swoop helm-smex helm-gtags helm-ag graphviz-dot-mode gnuplot-mode gnuplot fzf find-file-in-project fasd evil ess engine-mode elpy ein ediprolog eclim dracula-theme dired-subtree dashboard cuda-mode cmake-mode cider back-button all-the-icons-dired ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

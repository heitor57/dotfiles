(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq tab-width 2)
(setq package-enable-at-startup nil)
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(package-initialize)
(setq inhibit-startup-screen t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq initial-scratch-message
      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%%%%%%%@@@@@@@%@
@@@@@&%%%%%%&@@@@@@@@@@@%%@@@@@@@@%%@@@@@%%%%%%%%%%%%%%%%%%
@@@@@%%%%%%%@@@@@@@@@@@@@%%%%@@@@@%@@@@@@%%%%%%%%%%%%%%%%%%
@@@@@%%%%%%%@@@@@@@@@@@@@@%%%%%%@@%@@@@@%%%%%%%%%%%%%%%%%%%
@@@@%%%%%%%@@@@@@@@@@@@@@@%%%%%%%%@@@@@@@@%%%%%%%%%%%%%%%@@
@@@@%%%%%%%@@@@@@@@@@@@@@@@%%%%%%%@@@@@@@%%%%%%%%@@@@@@@@@@
@@@@%%%%%%%@@@@@%@@@@@@@@@@@%%%%%%@@@@@@%%%%%%%%@@@@@@@@@@@
@@@%%%%%%%@@@@@@%@@@@@@@@@@@&%%%%@@@@@@%%%%%%%%%@@@@@@@@@@@
@@@%%%%%%%@@@@@%%%@@@@@@@@@@@%%%%@@@@@&%%%%%%%%@@@@@@@@@@@@
@@&%%%%%%&@@@@@%%%%@@@@@@@@@@@%%&@@@@@%%%%%%%%%@@@@@@@@@@@@
@@%%%%%%%@@@@@@%%%%@@@@@@@@@@@%%@@@@@@%%%%%%%%%@@@@@@@@@@@@
@@%%%%%%%@@@@@%%%%%%@@@@@@@@@@@%@@@@@%%%%%%%%%%@@@@@@@@@@@@
@%%%%%%%&@@@@@%%%%%%&@@@@@@@@@@@@@@@@%%%%%%%%%%@@@@@@@@@@@@
@%%%%%%%@@@@@@%%%%%%%@@@@@@@@@@@@@@@@%%%%%%%%%%@@@@@@@@@@@@
@%%%%%%%@@@@@%%%%%%%%%@@@@@@@@@@@@@@%%%%%%%%%%%%@@@@@@@@@@@
%%%%%%%@@@@@@%%%%%%%%%%@@@@@@@@@@@@@%%%%%%%%%%%%%@@@@@@@@@@
%%%%%%%@@@@@&%%%%%%%%%%@@@@@@@@@@@@@%%%%%%%%%%%%@@@@@@@@@@@




"
      )

(setq gc-cons-threshold 402653184)
(setq gc-cons-percentage 0.6)
(global-linum-mode t)
;;(setq initial-buffer-choice t)
;;(setq initial-buffer-choice "")
;;hide bars
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; file explorer
					;(global-hl-line-mode +1)
;;use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; open with
(use-package openwith
  :config
  (setq openwith-associations '(("\\.pdf\\'" "zathura" (file))
				("\\.html\\'" "firefox" (file))))
  (openwith-mode t)
  )


;; evil
(setq use-package-always-ensure t)
(use-package evil
  :config
  (evil-mode t)
  (define-key evil-normal-state-map (kbd "z c") 'flyspell-auto-correct-word)

  (define-key evil-normal-state-map (kbd "z 1") 'org-latex-export-to-pdf)

  (define-key evil-normal-state-map (kbd "z 2") 
    (lambda () (interactive) 
      (async-shell-command
       (concat "zathura doc.pdf"))))
  
  ;; (define-key evil-normal-state-map (kbd "m m") 'buffer-menu)
  (define-key evil-normal-state-map (kbd "<f5>") 'save-some-buffers)
  )



;; (define-key evil-normal-state-map (kbd "z m")
;;   (lambda () (interactive) (async-shell-command
;; 			    (concat "pandoc " buffer-file-name " -t beamer -o pres.pdf")
;; 			    ))
;;   )

;; (define-key evil-normal-state-map (kbd "z g")
;;   (lambda () (interactive) (async-shell-command
;; 			    (concat "pandoc " buffer-file-name " -t beamer -o pres.pdf")
;; 			    )
;;     (async-shell-command
;;      (concat "zathura pres.pdf")
;;      )

;;     )
;;   )

;; multiple-cursors multiple cursors
;; (use-package multiple-cursors
;;   :config
;;   (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;   )
;; hideshow
(load-library "hideshow")
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(defun toggle-hiding (column)
  (interactive "P")
  (if hs-minor-mode
      (if (condition-case nil
	      (hs-toggle-hiding)
	    (error t))
	  (hs-show-all))
    (toggle-selective-display column)))
(define-key evil-normal-state-map (kbd "z a") 'toggle-hiding)
(define-key evil-normal-state-map (kbd "z M") 'hs-hide-all)
(define-key evil-normal-state-map (kbd "z R") 'hs-show-all)

(define-key evil-normal-state-map (kbd "z p") 'preview-buffer)
(define-key evil-normal-state-map (kbd "z ç") 'preview-clearout-buffer)
(define-key evil-normal-state-map (kbd "z o") 'preview-at-point)
(define-key evil-normal-state-map (kbd "z l") 'preview-clearout-at-point)
;; helm
(use-package helm
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (use-package helm-gtags
    :config
    (global-set-key (kbd "C-c C-.") 'helm-gtags-dwim))
  (use-package helm-swoop))
;; 
					(use-package markdown-mode)
(use-package page-break-lines)
					(use-package projectile)

;; Clojure Interactive Development Environment
					(use-package cider)
;; (use-package telephone-line
;;   :config

;; (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
;;       telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
;;       telephone-line-primary-right-separator 'telephone-line-cubed-right
;;       telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
;; (setq telephone-line-height 24
;;       telephone-line-evil-use-short-tag t)
;;   (telephone-line-mode 1))
(use-package moe-theme
  :config
  (moe-dark)
					;(moe-theme-set-color 'orange)
  ;(moe-theme-random-color)
  ;(moe-theme-set-color 'orange)
  (moe-theme-set-color 'cyan)
  )
(use-package smex
  :config
					;(global-set-key (kbd "M-x") 'smex)
					;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
					;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
					;(smex-initialize)
  )
(use-package helm-smex
  :config
  (global-set-key (kbd "M-x") #'helm-smex)
  (global-set-key (kbd "M-X") #'helm-smex-major-mode-commands))
(use-package magit)
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
					; set banner
 (setq dashboard-startup-banner nil)
					; set items
  (setq dashboard-items '((recents  . 5)
			  (bookmarks . 5)
			  (projects . 8)
			  (agenda . 5)
			  (registers . 5)))
 

  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  )
;; org-mode org orgmode
(use-package org-ref
  ;;:defer 2
  )
(use-package org
  ;;:defer 2
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t)
     (R . t)
     (shell . t)
     (dot . t)
     ))
  (org-toggle-inline-images)
  (setq org-latex-caption-above nil)
  ;; orgagenda tasks
  (setq org-agenda-files  '("~/agenda.org"))
  (setq org-log-done 'time)
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)


  ;; (use-package org-bullets
  ;;   :config
  ;;   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
  (global-visual-line-mode 1)

					;; (setq org-latex-listings 'minted
					;;      org-latex-packages-alist '(("" "minted")))
  (setq org-latex-pdf-process '("latexmk -pdflatex='pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f' -pdf -bibtex %f"))
					;(setq org-latex-pdf-process '("pdflatex -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f"))

					;
					;'("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
					;"")
  (setq ;;org-src-preserve-indentation t
   ;;indent-tabs-mode nil
   org-confirm-babel-evaluate nil)
  (setq org-src-tab-acts-natively t)
	(plist-put org-format-latex-options :scale 2)


(require 'org-tempo)
  )

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
	       '("beamer"
		 "\\documentclass\[presentation\]\{beamer\}"
		 ("\\section\{%s\}" . "\\section*\{%s\}")
		 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
		 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
  )

;; programming
(use-package iedit)
(use-package auto-complete
  :config
  (ac-config-default))
(use-package yasnippet
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode 1))

;; c
(setq c-default-style "linux"
      c-basic-offset 2)
(use-package auto-complete-c-headers
  :config
  (defun my:ac-c-headers-init ()
    (require 'auto-complete-c-headers)
    (add-to-list 'ac-sources 'ac-source-c-headers))
  (add-hook 'c++-mode-hook 'my:ac-c-headers-init)
  (add-hook 'c-mode-hook 'my:ac-c-headers-init)
  (add-to-list 'achead:include-directories '"/usr/include"))
;; (use-package google-c-style
;;   :config
;;   (add-hook 'c-mode-common-hook 'google-set-c-style)
;;   )

;; R
					;(use-package ess)
(use-package mips-mode :mode "\\.asm$")
;; rmarkdown

(use-package polymode)
(use-package poly-markdown)
(add-to-list 'auto-mode-alist '("\\.rmd" . poly-markdown-mode))

(defvar rmd-render-history nil "History list for spa/rmd-render.")
(defun spa/rmd-render (arg)
  "Render the current Rmd file to PDF output.
   With a prefix arg, edit the R command in the minibuffer"
  (interactive "P")
  ;; Build the default R render command
  (setq rcmd (concat "rmarkdown::render('" buffer-file-name "',"
		     "output_dir = '.',"
		     "output_format = 'pdf_document')"))
  ;; Check for prefix argument
  (if arg
      (progn
	;; Use last command as the default (if non-nil)
	(setq prev-history (car rmd-render-history))
	(if prev-history
	    (setq rcmd prev-history)
	  nil)
	;; Allow the user to modify rcmd
	(setq rcmd
	      (read-from-minibuffer "Run: " rcmd nil nil 'rmd-render-history))
	)
    ;; With no prefix arg, add default rcmd to history
    (setq rmd-render-history (add-to-history 'rmd-render-history rcmd)))
  ;; Build and evaluate the shell command
  (setq command (concat "echo \"" rcmd "\" | R --vanilla"))
  (compile command))
(global-set-key (kbd "C-c r") 'spa/rmd-render)
;; latex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
					;(setq TeX-PDF-mode t)

(require 'flymake)

(defun flymake-get-tex-args (file-name)
  (list "pdflatex"
	(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
(add-hook 'LaTeX-mode-hook 'flymake-mode)
(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

;; Writing
(setq ispell-dictionary "brasileiro")


;; math calc

(defun calc-eval-region (arg beg end)
  "Calculate the region and display the result in the echo area.
With prefix ARG non-nil, insert the result at the end of region."
  (interactive "P\nr")
  (let* ((expr (buffer-substring-no-properties beg end))
	 (result (calc-eval expr)))
    (if (null arg)
	(message "%s = %s" expr result)
      (goto-char end)
      (save-excursion
	(insert result)))))
;; finder, fuzzy finder fzf, ag
(use-package fzf)
(defcustom personal-ff "~/Documents"
  "fuzzy finder personal local"
  :type 'string)


(define-key evil-normal-state-map (kbd "f f")
  (lambda () (interactive) 
    (fzf/start personal-ff)
    ))
(define-key evil-normal-state-map (kbd "f d")
  (lambda () (interactive) 
    (find-file "~/dotfiles/.emacs")
    ))
(define-key evil-normal-state-map (kbd "f 1")
  (lambda () (interactive) 
    (find-file "~/cs/aeds3/tp1")
    ))
(define-key evil-normal-state-map (kbd "f 2")
  (lambda () (interactive) 
    (find-file "~/cs/aeds3/tp2")
    ))

(global-set-key (kbd "C-c C-c") (lambda () (interactive) 
				  (find-file "~/dotfiles/.emacs")
				  ))
(use-package helm-ag)
(define-key evil-normal-state-map (kbd "f a") 'helm-ag)
;; ETC
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ;; Also handle undocumented (<active> <inactive>) form.
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 '(85 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)
;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
					;(transparency 80)
;; ace mode

(use-package ace-jump-mode
  :config
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
  )

;; dired
(setq dired-listing-switches "-alh")
(define-key dired-mode-map ";" 'dired-kill-tree)
(use-package all-the-icons)
(use-package all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  )

;; server

					; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )
					; disable scroll bar on new frames
(add-to-list 'default-frame-alist
	     '(vertical-scroll-bars . nil))


;; startup time

(add-hook 'emacs-startup-hook
	  (lambda ()
	    
	    (setq gc-cons-threshold 16777216)
	    (setq gc-cons-percentage 0.1)))

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "Emacs ready in %s with %d garbage collections."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time)))
		     gcs-done)))

(use-package graphviz-dot-mode)
;; ranger
(use-package ranger)
(define-key evil-normal-state-map (kbd "m") 'ranger)
;; vars variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mips-interpreter "/usr/bin/qtspim")
 '(package-selected-packages
   (quote
    (ranger graphviz-dot-mode org-re-reveal-ref multiple-cursors mips-mode all-the-icons-install-fonts all-the-icons-dired all-the-icons-dired-mode esup yasnippet yasnippet-snippets use-package telephone-line projectile poly-markdown org-ref org-bullets openwith moe-theme magit lua-mode iedit helm-swoop helm-smex helm-gtags helm-ag fzf evil ess dired-hacks-utils dashboard cider auto-complete-c-headers ace-jump-mode)))
 '(personal-ff "~/cs"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

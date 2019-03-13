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
(global-linum-mode t)
;;(setq initial-buffer-choice t)
;;(setq initial-buffer-choice "")
;;hide bars
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1) 
;; file explorer


;;use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
;; evil
(setq use-package-always-ensure t)
(use-package evil
  :config
  (evil-mode t)
  )


(define-key evil-normal-state-map (kbd "z 1") 'org-latex-export-to-pdf)

(define-key evil-normal-state-map (kbd "z 2") 
(lambda () (interactive) 
		(async-shell-command
		 (concat "zathura doc.pdf"))))

(define-key evil-normal-state-map (kbd "z m")
  (lambda () (interactive) (async-shell-command
			    (concat "pandoc " buffer-file-name " -t beamer -o pres.pdf")
			    ))
)

(define-key evil-normal-state-map (kbd "z g")
  (lambda () (interactive) (async-shell-command
			    (concat "pandoc " buffer-file-name " -t beamer -o pres.pdf")
			    )
(async-shell-command
			    (concat "zathura pres.pdf")
			    )

		)
)


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
(use-package cider)
(use-package telephone-line
  :config
  (telephone-line-mode 1))
(use-package moe-theme
  :config
  (moe-dark)
  (moe-theme-set-color 'orange))
(use-package smex
  :config
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  (smex-initialize))
(use-package helm-smex
  :config
  (global-set-key (kbd "M-x") #'helm-smex)
  (global-set-key (kbd "M-X") #'helm-smex-major-mode-commands))
(use-package magit)
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
					; set banner
  (setq dashboard-startup-banner 2)
					; set items
  (setq dashboard-items '((recents  . 5)
			  (bookmarks . 5)
			  (projects . 8)
			  (agenda . 5)
			  (registers . 5)))
  )
;; org-mode
(use-package org-ref)
(use-package org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (C . t)
     (R . t)
     ))
  (org-toggle-inline-images)
  (setq org-latex-caption-above nil)
  )
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(global-visual-line-mode 1)

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f' -pdf -bibtex -f %f"))
;'("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;"")
(setq ;;org-src-preserve-indentation t
 ;;indent-tabs-mode nil
 org-confirm-babel-evaluate nil)
(setq org-src-tab-acts-natively t)


(add-to-list 'org-latex-classes
	     '("beamer"
	       "\\documentclass\[presentation\]\{beamer\}"
	       ("\\section\{%s\}" . "\\section*\{%s\}")
	       ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
	       ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))



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
(use-package ess)
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
(define-key evil-normal-state-map (kbd "f f")
  (lambda () (interactive) 
			    (fzf/start "~/computer-science/aeds3/tp1")
			    ))
(define-key evil-normal-state-map (kbd "f d")
  (lambda () (interactive) 
			    (find-file "~/dotfiles/.emacs")
			    ))
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
(transparency 80)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-package-update ag swiper fzf helm-ag helm-projectile fontawesome org-ref ess-R-data-view ess-smart-equals ess-view ess helm-gtags yasnippet-snippets use-package smart-mode-line-powerline-theme restart-emacs rainbow-mode projectile org-link-minor-mode org-evil org-bullets moe-theme markdown-mode magit iedit htmlize helm-smex google-c-style evil-org dashboard cider auto-complete-c-headers auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

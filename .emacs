(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(setq inhibit-startup-screen t)
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
;; helm
(use-package helm
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (use-package helm-gtags
    :config
    (global-set-key (kbd "C-c C-.") 'helm-gtags-dwim)))
;; 
(use-package markdown-mode)
(use-package page-break-lines)
(use-package projectile)
(use-package cider)
(use-package powerline
  :config
  (powerline-default-theme))
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
  (dashboard-setup-startup-hook))
;; org-mode
(use-package org)
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
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
(use-package auto-complete-c-headers
  :config
  (defun my:ac-c-headers-init ()
    (require 'auto-complete-c-headers)
    (add-to-list 'ac-sources 'ac-source-c-headers))
  (add-hook 'c++-mode-hook 'my:ac-c-headers-init)
  (add-hook 'c-mode-hook 'my:ac-c-headers-init)
  (add-to-list 'achead:include-directories '"/usr/include"))
;;(use-package google-c-style)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-gtags yasnippet-snippets use-package smart-mode-line-powerline-theme restart-emacs rainbow-mode projectile org-link-minor-mode org-evil org-bullets moe-theme markdown-mode magit iedit htmlize helm-smex google-c-style evil-org dashboard cider auto-complete-c-headers auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

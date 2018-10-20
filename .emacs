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
  )
;; 
(use-package markdown-mode)
(use-package page-break-lines)
(use-package projectile)
(use-package cider)
(use-package auto-complete
  :config
  (ac-config-default))
(use-package powerline
  :config
  (powerline-default-theme))
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(package-selected-packages
   (quote
    (restart-emacs helm-smex smex cider evil-visual-mark-mode evil-anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

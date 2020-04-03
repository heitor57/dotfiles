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
(set-default-font "Fira Code" nil t)
(add-to-list 'default-frame-alist
	     '(vertical-scroll-bars . nil))

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

(use-package evil
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "<f5>") 'save-some-buffers)
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
    ; duff
    ("d" (dired-connect-ssh "heitor" "200.17.66.6") "duff")
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
(setq org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex -interaction nonstopmode -output-diretory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f"))

(use-package org-ref)


(use-package projectile
  :config
  (projectile-mode +1)
  ;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (define-key evil-normal-state-map (kbd "z p") 'projectile-command-map)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-mode zenburn-theme yaml-mode web-mode use-package solarized-theme ranger projectile poly-markdown org-ref org-bullets openwith nimbus-theme neotree moe-theme mips-mode magit lua-mode kaolin-themes impatient-mode iedit helm-swoop helm-smex helm-gtags helm-ag graphviz-dot-mode gnuplot-mode gnuplot fzf find-file-in-project fasd evil ess engine-mode elpy ein ediprolog eclim dracula-theme dired-subtree dashboard cuda-mode cmake-mode cider back-button all-the-icons-dired ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

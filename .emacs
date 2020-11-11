(require 'package)
(package-initialize)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~") "/.local/bin"))
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist
	     '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(font . "Hack 10"))
;; (setq-default indent-tabs-mode nil)

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
				("\\.jar\\'" "java -jar " (file))
				("\\.mkv\\'" "mpv " (file))
				("\\.mp4\\'" "mpv " (file))
				("\\.eps\\'" "evince " (file))
				("\\.png\\'" "sxiv " (file))

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

  (define-key evil-normal-state-map (kbd "z 3") 'org-beamer-export-to-pdf)
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
  (setq dashboard-items '((recents  . 60)
			  (bookmarks . 5)
			  (projects . 8)
			  (agenda . 8)
			  (registers . 5)))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))

(use-package company
  :config
  (setq company-idle-delay 0)
  (use-package company-irony
    :config
    (add-to-list 'company-backends 'company-irony)
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'objc-mode-hook 'irony-mode)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    )
  (use-package company-anaconda
    :config
    (add-to-list 'company-backends 'company-anaconda)
    (add-hook 'python-mode-hook 'anaconda-mode))
  (add-hook 'after-init-hook 'global-company-mode)

  )

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
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t)
     (R . t)
     (shell . t)
     (dot . t)
     (gnuplot . t)
     (python . t)
     (sql . t)
     ))
  (setq org-confirm-babel-evaluate nil)
  (setq org-startup-truncated nil)
  (setq org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex -interaction nonstopmode -output-diretory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f"))
  ;; (setq org-latex-pdf-process '("pdflatex %f" "bibtex %b" "pdflatex %f" "pdflatex %f"))
  (setq org-latex-prefer-user-labels 1)
  (setq org-beamer-frame-level 2)
  )

;; (with-eval-after-load 'ox-latex
;;   (add-to-list 'org-latex-classes
;; 	       '("beamer"
;; 		 "\\documentclass\[presentation\]\{beamer\}"
;; 		 ("\\section\{%s\}" . "\\section*\{%s\}")
;; 		 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
;; 		 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
;;   )

(use-package org-ref)
(use-package auctex)
(use-package ein
  :config
  (setq ein:worksheet-enable-undo t)
  )

(use-package projectile
  :config
  (projectile-mode +1)
  ;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (define-key evil-normal-state-map (kbd "´") 'projectile-command-map)
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
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  )

;; (use-package dracula-theme)
;; (use-package minsk-theme)
(use-package google-translate
  :init (setq google-translate-translation-directions-alist '(("en" . "pt")))
  :config
  (setq google-translate-backend-method 'curl)
  (setq google-translate-output-destination nil)
  :bind (("\C-ct" . google-translate-smooth-translate))
  )

(use-package kotlin-mode
  :config
  (define-key evil-normal-state-map (kbd "f k") '(lambda () (interactive)
                                                   (call-process-shell-command
                                                    (concat "kotlinr " (buffer-file-name)) nil 0)))
  )
(use-package material-theme)
(use-package ace-jump-mode
  :config
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
  )
;; (call-process-shell-command
;;        (concat "kotlin " (buffer-file-name)) nil t)

;; (call-process-shell-command
;;  (concat "kotlinr " (buffer-file-name)) nil t)

(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray7")
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (add-hook 'latex-mode-hook 'turn-on-auto-fill)
;; (add-hook 'python-mode-hook 'turn-on-auto-fill)
(eval-after-load "artist"
  '(define-key artist-mode-map (kbd "C-,") 'artist-mouse-choose-operation)
  )
(defun how-many-region (begin end regexp &optional interactive)
  "Print number of non-trivial matches for REGEXP in region.                    
   Non-interactive arguments are Begin End Regexp"
  (interactive "r\nsHow many matches for (regexp): \np")
  (let ((count 0) opoint)
    (save-excursion
      (setq end (or end (point-max)))
      (goto-char (or begin (point)))
      (while (and (< (setq opoint (point)) end)
                  (re-search-forward regexp end t))
        (if (= opoint (point))
            (forward-char 1)
          (setq count (1+ count))))
      (if interactive (message "%d occurrences" count))
      count)))

(defun infer-indentation-style ()
  ;; if our source file uses tabs, we use tabs, if spaces spaces, and if        
  ;; neither, we use the current indent-tabs-mode                               
  (progn
    (setq indent-tabs-mode nil)
    (let ((space-count (how-many-region (point-min) (point-max) "^  "))
          (tab-count (how-many-region (point-min) (point-max) "^\t")))
      (if (> space-count tab-count) (setq indent-tabs-mode nil))
      (if (> tab-count space-count) (setq indent-tabs-mode t)))
    )
  )

;; (add-hook 'python-mode-hook 'infer-indentation-style)

(setq ispell-dictionary "brasileiro")
(setq org-time-stamp-formats '("<%Y-%m-%d %H:%M> " . "<%Y-%m-%d %a %H:%M>"))
(evil-set-initial-state 'nov-mode 'emacs)
(evil-set-initial-state 'calendar 'emacs)
(evil-set-initial-state 'ses-mode 'emacs)
(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))
(use-package smartparens)
(use-package all-the-icons
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  )
(require 'org-tempo)
;; (use-package spaceline
;;   :config
;;   (require 'spaceline-config)
;;   )

;; (define-key dired-mode-map (kbd "F")
;;   (lambda ()
;;     (interactive)
;;     (message (dired-get-marked-files))))
(setq-default indent-tabs-mode nil)
(global-undo-tree-mode)
;; (add-hook 'image-mode-hook
;;   (lambda ()
;;     (auto-revert-mode)
;;     (auto-image-file-mode)))
(use-package indent-tools
  :config
  (global-set-key (kbd "C-c >") 'indent-tools-hydra/body)
  )

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  )

;; (use-package flycheck
;;   :config
;;   (setq flycheck-python-pycompile-executable "python3")
;;   (global-flycheck-mode)
;;   )
;; (use-package flycheck-irony
;;   :config
;;   (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
;; (use-package irony-eldoc
;;   :config
;;   (add-hook 'irony-mode-hook #'irony-eldoc)
;;   )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-undo-system 'undo-tree)
 '(org-ref-pdf-directory "~/Downloads/")
 '(package-selected-packages
   '(irony-eldoc flycheck-irony flycheck irony-server company-irony helm-projectile company-jedi indent-tools org-tempo smartparens nov ace-jump material-theme kotlin-mode minsk-theme modus-vivendi-theme auctex django-mode company-mode yaml-mode web-mode use-package solarized-theme ranger projectile poly-markdown org-ref org-bullets openwith nimbus-theme neotree moe-theme mips-mode magit lua-mode kaolin-themes impatient-mode iedit helm-swoop helm-smex helm-gtags helm-ag graphviz-dot-mode gnuplot-mode gnuplot fzf find-file-in-project fasd evil ess engine-mode elpy ein ediprolog eclim dracula-theme dired-subtree dashboard cuda-mode cmake-mode cider back-button all-the-icons-dired ace-jump-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

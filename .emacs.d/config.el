(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-strech-cursor t)

(setq undo-limit 80000000 
      evil-want-fine-undo t
      auto-save-default t
      truncate-string-ellipsis "...")

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

;; window default size
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 100))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function 'ignore)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Instalar use-package
(straight-use-package 'use-package)
;; use-package insatalara mediante straight
(setq straight-use-package-by-default t)

(use-package all-the-icons)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "wololo")
  (setq dashboard-startup-banner 'logo))
  ;(setq dashboard-startup-banner "c:/Users/jpbri/Pictures/emacs_stuff/banner.txt"))

;; evil-mode
(use-package evil
:init
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-vsplit-window-right t)
(setq evil-split-window-below t)
:hook (after-init . evil-mode))

;; evil-collection
(use-package evil-collection
:hook (after-init . evil-collection-init))

(use-package which-key
:init
    (setq which-key-side-window-location 'bottom))
  (which-key-mode)

(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-directory "~/Org/"
      org-agenda-files '("~/Org/agenda.org")
      org-default-notes-file (expand-file-name "notes.org" org-directory))

(setq org-todo-keywords
      '((sequence
         "TODO(t)"         ; Tarea por hacer.
         "START(s)"        ; Tarea empezada.
         "WAIT(w)"         ; Tarea en espera de algo.
         "PROJ(p)"         ; A project tha contains other tasks
         "|"               ; divide tareas "activas" y "inactivas"
         "DONE(d)"         ; Tarea lista
         "CANCELLED(c)"))) ; Tarea cancelada

(use-package doom-themes)
(setq doom-themes-enable-bold t
      doom-thems-enable-italic t)

(load-theme 'doom-vibrant t)

(use-package projectile
  :config
  (projectile-global-mode 1))

(use-package magit)
(use-package magit-todos
  :config (magit-todos-mode))

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode) 
  :custom (pdf-tools-handle-upgrades nil)
  :config (pdf-tools-install))

;Para que abra los pdf dentro de emacs
(add-to-list 'org-file-apps '("\\.pdf\\'" . emacs))
;Para que los pdfs se abran a la derecha
(add-to-list
 'display-buffer-alist
 '("\\.pdf$*" (display-buffer-reuse-window display-buffer-in-side-window)
   (window-width . 0.5)
   (side . right)))

(use-package markdown-mode)
(use-package lua-mode)
(use-package python-mode)

(use-package general
:config
(general-evil-setup t))

(nvmap :prefix "SPC"
"b b" '(ibuffer :which-key "ibuffer"))

(nvmap :prefix "SPC"
"o e" '(eshell :wich-key "Eshell"))

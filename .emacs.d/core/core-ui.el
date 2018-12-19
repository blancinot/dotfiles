;;; core-ui.el
;; Author: Benjamin Lancinot

;; Gestion de l'affichage en général, buffer, fenètres, paramètrage, barre.

;; Désactive menu-bar, tool-bar et scroll-bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Désactive scintillement du curseur
(blink-cursor-mode -1)

;; yes -> y, no -> n
(fset 'yes-or-no-p 'y-or-n-p)

(setq gc-cons-threshold 100000000)

;; Désactive startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Désactive ring-bell
(setq ring-bell-function 'ignore) ; disable the annoying bell ring

;; Scrolling plus sympa
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; Active affichage colonnes et lignes
(line-number-mode t)
(column-number-mode t)

;; Paramètres d'indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default indicate-empty-lines nil)

;; UTF8 only
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; whitespace clean-up
 (add-hook 'before-save-hook 'whitespace-cleanup)

;; Fenètre automatiquement dimensionnée au démarrage en demi-écran
(when window-system (set-frame-size (selected-frame) 115 60))

;; Ne tronque pas les mots
(setq truncate-partial-width-windows nil)

;; Surligne la ligne courante
(global-hl-line-mode 1)

;; Affiche les espaces inutiles
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; Charge le theme : zenburn
(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-enable-bright-minibuffer t
      doom-enable-bright-buffers t)

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-city-lights t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; neotree
(use-package all-the-icons)
;(doom-themes-neotree-config)
(setq doom-neotree-line-spacing 1)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;; Gère l'affichade de la mode-line(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(defconst RIGHT_PADDING 1)

(defun reserve-left/middle ()
  (/ (length (format-mode-line mode-line-align-middle)) 2))

(defun reserve-middle/right ()
  (+ RIGHT_PADDING (length (format-mode-line mode-line-align-right))))

(setq mode-line-align-left
      '(" "
        (:propertize " %I " face mode-line-position-grey-face)
        (:propertize " %l:%c " face mode-line-position-face)
        (vc-mode vc-mode)
        ))

(setq mode-line-align-middle
      '(
        (:propertize (:eval (shorten-directory default-directory 30)) face mode-line-folder-face)
        (:propertize "%b " face mode-line-filename-face)
        ))


(setq mode-line-align-right
      '(                                        ; read-only or modified status
        (:eval
         (cond (buffer-read-only (propertize " RO " 'face 'mode-line-read-only-face))
               ((buffer-modified-p)(propertize " ** " 'face 'mode-line-modified-face))
               (t (propertize "    " 'face 'mode-line-position-face))))
        (:propertize " %p " face mode-line-position-grey-face)))



(setq-default mode-line-format
              (list
               mode-line-align-left
               '(:eval (mode-line-fill-center 'mode-line
                                              (reserve-left/middle)))
               mode-line-align-middle
               '(:eval
                 (mode-line-fill-right 'mode-line
                                       (reserve-middle/right)))
               mode-line-align-right
               ))


;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 8)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

;; Extra mode line faces
;; (make-face 'mode-line-read-only-face)
;; (make-face 'mode-line-modified-face)
;; (make-face 'mode-line-filename-face)
;; (make-face 'mode-line-position-face)
;; (make-face 'mode-line-position-grey-face)
;; (make-face 'mode-line-folder-face)

(provide 'core-ui)

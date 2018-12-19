;; core-packages.el
;; Author: Benjamin Lancinot

;; Gestion des configurations des packages installés


;; Package: clean-aindent-mode
(use-package clean-aindent-mode
  :init
  (add-hook 'prog-mode-hook 'clean-aindent-mode))



;; Package: dtrt-indent
(use-package dtrt-indent
  :init
  (dtrt-indent-mode 1)
  (setq dtrt-indent-verbosity 0))

;; Package: ws-butler
(use-package ws-butler
  :init
  (add-hook 'prog-mode-hook 'ws-butler-mode)
  (add-hook 'text-mode 'ws-butler-mode)
  (add-hook 'fundamental-mode 'ws-butler-mode))

(use-package windmove
  :config
  ;; use shift + arrow keys to switch between visible buffers
(windmove-default-keybindings))

;; PACKAGE: anzu
;; GROUP: Editing -> Matching -> Isearch -> Anzu
(use-package anzu
  :bind (("M-%"  . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :init
  (global-anzu-mode))

;; PACKAGE: iedit
(use-package iedit
  :bind (("C-S-r" . iedit-mode))
  :init
(setq iedit-toggle-key-default nil))


;; ;; Package: undo-tree
;; Undo && Redo
(use-package undo-tree
  :bind(("C-z"       . undo)
        ("C-S-z"     . redo))
  :init
  (global-undo-tree-mode 1))

;; PACKAGE: smartparens
(use-package smartparens
  :init
  (progn
    (use-package smartparens-config)
    (use-package smartparens-ruby)
    (use-package smartparens-html)
    (smartparens-global-mode 1)
    (show-smartparens-global-mode 1))
  :config
  (progn
    (setq smartparens-strict-mode t)
    (sp-local-pair 'emacs-lisp-mode "`" nil :when '(sp-in-string-p)))
  :bind
  (("C-M-k" . sp-kill-sexp-with-a-twist-of-lime)
   ("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-n" . sp-up-sexp)
   ("C-M-d" . sp-down-sexp)
   ("C-M-u" . sp-backward-up-sexp)
   ("C-M-p" . sp-backward-down-sexp)
   ("C-M-w" . sp-copy-sexp)
   ("M-s" . sp-splice-sexp)
   ("M-r" . sp-splice-sexp-killing-around)
   ("C-)" . sp-forward-slurp-sexp)
   ("C-}" . sp-forward-barf-sexp)
   ("C-(" . sp-backward-slurp-sexp)
   ("C-{" . sp-backward-barf-sexp)
   ("M-S" . sp-split-sexp)
   ("M-J" . sp-join-sexp)
("C-M-t" . sp-transpose-sexp)))


;; Package: yasnippet
;; GROUP: Editing -> Yasnippet
;; Package: yasnippet
(use-package yasnippet
  :defer t
  :init
   (add-hook 'prog-mode-hook 'yas-minor-mode)
   (yas-global-mode 1)
   (yas-reload-all)
   (setq yas-verbosity 1)
   ;; Wrap around region
   (setq yas-wrap-around-region t)
   (add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t))))


;; Package: projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t)
  :init
  (counsel-projectile-mode))

(use-package ggtags
  :ensure t
  :bind
  (("M-," . pop-tag-mark)))


(use-package swiper
  :demand
  :delight ivy-mode
  :bind (("C-s"     . swiper)
         ("C-r"     . swiper)
         ("C-c u"   . swiper-all)
         ("C-c C-r" . ivy-resume)
         ("C-c C-o" . ivy-occur)
         ("C-c C-b" . ivy-switch-buffer)
         ("C-c C-k" . kill-buffer))
  :config
  (progn (ivy-mode 1)
         (setq ivy-height 6)
         (setq enable-recursive-minibuffers t)
         (setq swiper-include-line-number-in-search t)
         (setq ivy-re-builders-alist
               '((counsel-M-x . ivy--regex-fuzzy)
                 (t . ivy--regex-plus)))

         (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial-or-done)))


;; ivy sorted via smex
(use-package smex
  :demand
  :config (setq smex-save-file (concat persistent-dir "/smex-items")))

(use-package counsel
  :after (ivy)
  :demand
  :delight counsel-mode
  :bind (("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-h f"   . counsel-describe-function)
         ("C-h v"   . counsel-describe-variable)
         ("C-c f r" . counsel-recentf)
         ("C-c g"   . counsel-git)
         ("C-c /"   . counsel-git-grep)
         ;; ("C-c k"   . counsel-ag)
         ("M-y"     . counsel-yank-pop))
  :config
  (progn (defun counsel-major-mode-commands (&optional initial-input)
           "Ivy version of `smex-major-mode-commands'.
Optional INITIAL-INPUT is the initial input in the minibuffer."
           (interactive)
           (unless initial-input
             (setq initial-input (cdr (assoc this-command
                                             ivy-initial-inputs-alist))))
           (let* ((cands obarray)
                  (pred 'commandp)
                  (sort t))
             (when (require 'smex nil 'noerror)
               (unless smex-initialized-p
                 (smex-initialize))
               (smex-detect-new-commands)
               (smex-update)
               (setq cands (delete-dups (append (smex-extract-commands-from-keymap (current-local-map))
                                                (smex-extract-commands-from-features major-mode))))
               (setq cands (smex-sort-according-to-cache cands))
               (setq cands (mapcar #'symbol-name cands))
               (setq pred nil)
               (setq sort nil))
             (ivy-read (counsel--M-x-prompt) cands
                       :predicate pred
                       :require-match t
                       :history 'extended-command-history
                       :action
                       (lambda (cmd)
                         (when (featurep 'smex)
                           (smex-rank (intern cmd)))
                         (let ((prefix-arg current-prefix-arg)
                               (this-command (intern cmd)))
                           (command-execute (intern cmd) 'record)))
                       :sort sort
                       :keymap counsel-describe-map
                       :initial-input initial-input
                       :caller 'counsel-major-mode-commands)))

         (defun counsel-describe-package ()
           "Forward to `describe-package'."
           (interactive)
           (ivy-read "Describe package: "
                     (let ((packages (append (mapcar 'car package-alist)
                                             (mapcar 'car package-archive-contents)
                                             (mapcar 'car package--builtins))))
                       (delq nil
                             (mapcar (lambda (elt)
                                       (symbol-name elt))
                                     packages)))
                     :action (lambda (x)
                               (describe-package (intern x)))
                     :caller 'counsel-describe-package))))

;; (use-package sr-speedbar
;;   :ensure t
;;   :bind (("C-c m" . sr-speedbar-toggle))
;;   :init
;; (setq speedbar-hide-button-brackets-flag t
;;       speedbar-show-unknown-files t
;;       speedbar-smart-directory-expand-flag t
;;       speedbar-directory-button-trim-method 'trim
;;       speedbar-use-images nil
;;       speedbar-indentation-width 2
;;       speedbar-use-imenu-flag t
;;       speedbar-file-unshown-regexp "flycheck-.*"
;;       sr-speedbar-width 35
;;       sr-speedbar-width-x 35
;;       sr-speedbar-auto-refresh nil
;;       sr-speedbar-skip-other-window-p t
;;       sr-speedbar-right-side nil))

(use-package neotree
  :config
  :bind (("C-c m" . neotree-toggle)))

;; (use-package doom-neotree
;;   :ensure nil
;;   :config
;;   (setq doom-neotree-enable-file-icons t))



(provide 'core-packages)

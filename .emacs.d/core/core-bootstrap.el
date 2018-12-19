;;; core-bootstrap.el
;; Author: Benjamin Lancinot

;; Gestion de l'installation des packages
;; Gestion des dépots

(require 'package)

;; Dépots à utiliser
(setq package-archives '(("gnu"      . "http://elpa.gnu.org/packages/")
                         ("melpa"    . "http://melpa.org/packages/")))

;; Tous les packages nécessaires
(defconst my-packages
  '(anzu
    use-package
    smex
    anzu
    flymd
    projectile
    ivy
    counsel
    swiper
    ggtags
    clean-aindent-mode
    comment-dwim-2
    dtrt-indent
    ws-butler
    iedit
    yasnippet
    smartparens
    undo-tree
    flycheck
    neotree
    exec-path-from-shell
    auto-complete
    zygospore
    counsel-projectile
    function-args
    doom-themes
    go-mode
    go-autocomplete
    flymake-go
    go-add-tags
    go-errcheck
    go-stacktracer))

;; Installe les packages s'ils ne le sont pas
(defun install-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package my-packages)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages)

(provide 'core-bootstrap)

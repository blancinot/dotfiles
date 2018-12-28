;; module-lang-go.el
;; Author: Benjamin Lancinot

(use-package go-mode
  :mode ("\\.go" . go-mode)
  :init
  :config
  (defun my-go-mode-hook ()
    (setq gofmt-command "goimports")
    (setq godoc-command "godoc")
    (setq tab-width 4)
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")

    (set (make-local-variable 'company-backends) '(company-go))
    (company-mode))

  (defun setup-go-mode-compile ()
    "Customize compile command to run go build"
    (if (not (string-match "go" compile-command))
        (set (make-local-variable 'compile-command)
             "go build -v && go test -v && go vet")))

  (add-hook 'go-mode-hook 'my-go-mode-hook)
  (add-hook 'go-mode-hook 'setup-go-mode-compile)

  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
  (add-hook 'go-mode-hook 'flycheck-mode)
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package go-add-tags
  :after go-mode)

(use-package go-errcheck
  :after go-mode)

(use-package go-guru
  :after go-mode
  :bind (("M-."   . go-guru-definition)
         ("C-c d" . go-guru-describe)))

(use-package company-go
  :after go-mode
  :ensure t)

;; ElDoc integration
(use-package go-eldoc
  :after go-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

;; Linting
(use-package flycheck-gometalinter
  :after go-mode
  :ensure t
  :config
  (progn
    (flycheck-gometalinter-setup))
  ;; skip linting for vendor dirs
  (setq flycheck-gometalinter-vendor t)
  ;; use in test files
  (setq flycheck-gometalinter-test t)
  ;; only use fast linters
  (setq flycheck-gometalinter-fast t)
  ;; explicitly disable 'gotype' linter
  (setq flycheck-gometalinter-disable-linters '("gotype")))


(provide 'module-lang-go)

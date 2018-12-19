;; module-lang-go.el
;; Author: Benjamin Lancinot

(require 'go-guru)

(use-package auto-complete)

(use-package go-mode
  :bind (:map go-mode-map
              ("C-c C-g" . go-goto-imports)
              ("C-c C-c" . compile))
  :config
  (progn (setq gofmt-command "goimports")
         (setq godoc-command "godoc")
         (setq tab-width 4)
         (exec-path-from-shell-initialize)
         (exec-path-from-shell-copy-env "GOPATH")


           (ac-config-default)

         ;;(add-hook 'go-mode-hook 'auto-complete-for-go)

         (defun go-prog-init ()
           "if go is install go get all dependencies for emacs go packages"
           (interactive)
           (if (not (eq (executable-find "go") nil))
               (progn
                 (mapcar (lambda (pkg)
                           (let ((cmd (concat "go get -v -u " pkg)))
                             (call-process-shell-command cmd nil "*go-get-output*" t)))
                         '("github.com/nsf/gocode"
                           "golang.org/x/tools/cmd/goimports"
                           "github.com/rogpeppe/godef"
                           "github.com/golang/lint"
                           "golang.org/x/tools/cmd/gorename"
                           "golang.org/x/tools/cmd/guru"
                           "github.com/kisielk/errcheck")))
             (message "go executable not found, install go from https://golang.org/download")))

         (defun setup-go-mode-compile ()
           "Customize compile command to run go build"
           (if (not (string-match "go" compile-command))
               (set (make-local-variable 'compile-command)
                    "go build -v && go test -v && go vet")))

         (add-hook 'go-mode-hook 'setup-go-mode-compile)

         (add-hook 'go-mode-hook 'flycheck-mode)

         (add-hook 'go-mode-hook 'go-eldoc-setup)

         ;; format before save
         (add-hook 'before-save-hook 'gofmt-before-save)))


(use-package go-autocomplete
  :after go-mode)

(use-package go-add-tags
  :after go-mode)

(use-package go-errcheck
  :after go-mode)

(use-package go-stacktracer)

(use-package go-guru
  :after go-mode
  :bind (("M-."   . go-guru-definition)
         ("M-*"   . pop-tag-mark)
         ("C-c d" . go-guru-describe)))



(use-package flycheck-gometalinter
  :after (go-mode flycheck-mode))

(provide 'module-lang-go)

;; module-lang-markdown.el
;; Author: Benjamin Lancinot

;; Markdown management

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package flymd
  :bind (("C-c f"   . flymd-flyit))
  :after (:any markdown-mode gfm-mode))

(provide 'module-lang-markdown)

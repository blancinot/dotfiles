;;; init.el
;; Author: Benjamin Lancinot

(package-initialize)

(defvar current-user
  (getenv
   (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "Powering up... Be patient, Master %s!" current-user)

(defvar emacs-dir (file-name-directory "~/.emacs.d/init.el")
  "The root dir of the Emacs distribution.")

(defvar core-dir (expand-file-name "core" emacs-dir)
  "The home of core functionality.")

(defvar modules-dir (expand-file-name "modules" emacs-dir)
  "This directory houses all of the modules.")

(defvar themes-dir (expand-file-name "themes" emacs-dir)
  "This directory houses all of the themes.")

(defvar persistent-dir (expand-file-name "persistent" emacs-dir)
  "This directory houses packages that are not yet available in ELPA (or MELPA).")

(unless (file-exists-p persistent-dir)
  (make-directory persistent-dir))

(add-to-list 'load-path core-dir)
(add-to-list 'load-path modules-dir)
(add-to-list 'load-path themes-dir)


(message "Loading core...")
(require 'core-ui)
(require 'core-paths)
(require 'core-bootstrap)
(require 'core-packages)
(require 'core-utils)

(message "Loading modules...")
;;(require 'module-lang-tex)
;; (require 'module-lang-c)
(require 'module-lang-go)
(require 'module-lang-markdown)

(message "Ready to do thy bidding, Master %s!" current-user)

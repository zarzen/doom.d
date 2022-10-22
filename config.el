;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Zhen Zhang"
      user-mail-address "zhangzhen.dev@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Menlo" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Notes/org")

(setq org-agenda-files (list org-directory
                             (concat org-directory "/side-projects")))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (add-hook 'pdf-view-mode-hook 'pdf-continuous-scroll-mode)

;; latext config
;; (setq +latex-viewers '(pdf-tools))
(setq-default Tex-master nil)

;; deft config
(setq deft-directory org-directory)
(setq deft-recursive t
      deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n"
      deft-use-filename-as-title t)

;;; config org-roam id
(setq org-id-method 'ts)
(setq org-id-ts-format "%Y-%m-%d[%H:%M:%S]"); (setq deft-use-filename-as-title nil)

;; expand-region.el
(define-key evil-visual-state-map (kbd "v") 'er/expand-region)

;; lsp-mode config
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-signature-auto-activate nil)

;; enable evil-matchit
(global-evil-matchit-mode 1)

;; config tree-sitter
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; set default directory
(setq default-directory (concat (getenv "HOME") "/"))

(add-to-list 'exec-path "C:\\Users\\Zhen Zhang\\.emacs.d\\.local\\straight\\repos\\emacsql\\sqlite")

;; config latex preview
(setq org-latex-create-formula-image-program 'dvisvgm)

;; set for org export
;; (setq org-id-extra-files '(find-lisp-find-files org-roam-directory "\.org$"))
;; "org-export-data: Unable to resolve link: FILE-ID"
(defun jnf/force-org-rebuild-cache ()
  "Rebuild the `org-mode' and `org-roam' cache."
  (interactive)
  (org-id-update-id-locations)
  ;; Note: you may need `org-roam-db-clear-all'
  ;; followed by `org-roam-db-sync'
  (org-roam-db-sync)
  (org-roam-update-org-id-locations))

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

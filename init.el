;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(tool-bar-mode -1)
(menu-bar-mode -1)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package company)
(use-package toml-mode)
(use-package racer)
(use-package smartparens)
(use-package helm)
(use-package helm-projectile)
(use-package markdown-mode)
(use-package undo-tree)
(use-package base16-theme)
(use-package cargo)
(use-package seq)
(use-package rust-playground)
(use-package yaml-mode)
(use-package edit-indirect)
(use-package multiple-cursors)
(use-package expand-region)

(use-package flycheck
  :init (global-flycheck-mode))
(use-package flycheck-rust)
(use-package flycheck-yamllint)
(use-package flycheck-inline)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(global-auto-revert-mode t)
(show-smartparens-global-mode 1)
(smartparens-global-mode 1)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))

(with-eval-after-load 'flycheck
  (flycheck-inline-mode))

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(add-hook 'rust-mode-hook 'hs-minor-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
(sp-local-pair 'rust-mode "'" nil :actions nil)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-undo-tree-mode)

(setq helm-split-window-inside-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    4 ; scroll 4 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-buffers-fuzzy-matching t          ; fuzzy matching buffer names when non-nil
      helm-echo-input-in-header-line t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-autoresize-mode 1)
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq racer-cmd "~/.cargo/bin/racer")
;;(setq racer-rust-src-path (expand-file-name (getenv "RUST_SRC_PATH")))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(helm-mode 1)
(global-visual-line-mode 1)

(load-theme 'base16-atelier-plateau t)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(define-key mc/keymap (kbd "<return>") nil)

(global-set-key (kbd "<M-up>") 'er/expand-region)
(global-set-key (kbd "<M-down>") 'er/contract-region)

(define-key helm-map (kbd "<left>") 'helm-previous-source)
(define-key helm-map (kbd "<right>") 'helm-next-source)
(customize-set-variable 'helm-ff-lynx-style-map t)

(set-face-attribute 'default nil :height 100)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (forward-line 1)
  (yank))
(global-set-key (kbd "M-D") 'duplicate-line)

(when (executable-find "rustc")
  (setenv "LD_LIBRARY_PATH"
	  (let* ((sysroot (s-trim-right
			   (shell-command-to-string
			    (format "%s --print sysroot" (executable-find "rustc")))))
		 (lib-path (f-join sysroot "lib")))
	    (when (file-exists-p lib-path) lib-path)
	    lib-path)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("542e6fee85eea8e47243a5647358c344111aa9c04510394720a3108803c8ddd1" "ffac21ab88a0f4603969a24b96993bd73a13fe0989db7ed76d94c305891fad64" "41eb3fe4c6b80c7ad156a8c52e9dd6093e8856c7bbf2b92cc3a4108ceb385087" "fc7fd2530b82a722ceb5b211f9e732d15ad41d5306c011253a0ba43aaf93dccc" "3e34e9bf818cf6301fcabae2005bba8e61b1caba97d95509c8da78cff5f2ec8e" "cabc32838ccceea97404f6fcb7ce791c6e38491fd19baa0fcfb336dcc5f6e23c" "1d079355c721b517fdc9891f0fda927fe3f87288f2e6cc3b8566655a64ca5453" "92192ea8f0bf04421f5b245d906701abaa7bb3b0d2b3b14fca2ee5ebb1da38d8" "760ce657e710a77bcf6df51d97e51aae2ee7db1fba21bbad07aab0fa0f42f834" "b3bcf1b12ef2a7606c7697d71b934ca0bdd495d52f901e73ce008c4c9825a3aa" "34ed3e2fa4a1cb2ce7400c7f1a6c8f12931d8021435bad841fdc1192bd1cc7da" "9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57" "6271fc9740379f8e2722f1510d481c1df1fcc43e48fa6641a5c19e954c21cc8f" "aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329" default)))
 '(helm-autoresize-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (toml-mode expand-region multiple-cursors rainbow-delimiters flycheck-inline json-mode helm-ag edit-indirect flymake-rust flycheck-yamllint rust-playground yaml-mode flymake-yaml rust-mode base16-theme helm-projectile smartparens undo-tree helm racer flycheck-rust company color-theme cargo async))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(global-auto-revert-mode t)
(show-smartparens-global-mode 1)
(smartparens-global-mode 1)

(require 'flymake-yaml) ;; Not necessary if using ELPA package
(add-hook 'yaml-mode-hook 'flymake-yaml-load)

(add-hook 'rust-mode-hook 'cargo-minor-mode)

(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
(sp-local-pair 'rust-mode "'" nil :actions nil)

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;;(require 'color-theme)
;;(color-theme-initialize)
;;(color-theme-charcoal-black)

(require 'helm)
(require 'helm-config)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-undo-tree-mode)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
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
(setq racer-rust-src-path (expand-file-name (getenv "RUST_SRC_PATH")))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(helm-mode 1)

(load-theme 'base16-atelier-plateau t)

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
    (yaml-mode flymake-yaml rust-mode base16-theme helm-projectile smartparens undo-tree helm racer flycheck-rust company color-theme cargo async))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(add-hook 'rust-mode-hook 'cargo-minor-mode)

(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

(require 'helm)
(require 'helm-config)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    4 ; scroll 4 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-buffers-fuzzy-matching t          ; fuzzy matching buffer names when non-nil
      helm-echo-input-in-header-line t)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-autoresize-mode 1)
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

(helm-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (helm racer flycheck-rust company color-theme cargo async))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

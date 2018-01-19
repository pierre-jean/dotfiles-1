(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
; Changes Yes/no with y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; No scrollbars
(set-fringe-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; prefer utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(tool-bar-mode -1)
(savehist-mode 1)

;;Persistent undo history
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist `((".*" . ,temporary-file-directory)))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome-stable")

(pkg
  smooth-scrolling
  :ensure t
  :init
  (setq scroll-margin 5
        scroll-conservatively 9999
        scroll-step 1))

; Backup files
(setq
   backup-by-copying t
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(setq vc-follow-symlinks t)

(pkg diminish :ensure t)

(provide 'general-config)

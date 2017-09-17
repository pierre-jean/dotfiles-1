;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(pkg helm
     :ensure t
     :init (pkg helm-projectile :ensure t)
     :config
     (require 'helm-config)
     (require 'helm-misc)
     (require 'helm-projectile)
     (require 'helm-locate)
     (helm-mode 1)
     (define-key evil-normal-state-map " " 'helm-mini)
     (setq
       helm-quick-update t
       helm-bookmark-show-location t
       helm-buffers-fuzzy-matching t)

     ;; Override default command launcher
     (global-set-key (kbd "M-x") 'helm-M-x))

(provide 'helm-fw)
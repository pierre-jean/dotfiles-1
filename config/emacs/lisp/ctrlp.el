(pkg
  helm-projectile
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file))

(provide 'ctrlp)

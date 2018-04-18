(use-package
  expand-region
  :ensure t
  :defer t
  :config
  )

(global-set-key (kbd "ESC <up>") 'er/expand-region)
(global-set-key (kbd "ESC <down>") 'er/contract-region)

(provide 'init-expand-region)

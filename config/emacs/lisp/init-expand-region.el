(use-package
  expand-region
  :ensure t
  :defer t
  :config
  (evil-leader/set-key "<up>" 'er/expand-region)
  (evil-leader/set-key "<down>" er/contract-region))

(provide 'init-expand-region)

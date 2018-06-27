(require 'init-programming-mode)

(use-package
  feature-mode
  :ensure t
  :defer t
  :mode "\\.feature$"
  :config
  (setq feature-indent-level 4)
  (setq feature-indent-offset 4)
  (set-compile-for 'feature-mode-hook "yarn test")
  (add-hook 'feature-mode-hook 'programming-mode))

(provide 'init-cucumber)

(require 'init-programming-mode)

(use-package
  yaml-mode
  :ensure t
  :mode "\\.ya?ml$"
  :config
  (add-hook 'yaml-mode-hook 'init-programming-mode))
(provide 'init-yaml)

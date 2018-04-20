(use-package
  typescript-mode
  :mode ("\\.ts?" . typescript-mode))

(use-package
  tide
  :ensure t
  :config
  (tide-setup)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)

  ; Bind tide keys
  (evil-leader/set-key "b" 'tide-jump-to-definition)
  (evil-leader/set-key "7" 'tide-references)

  (location-list-buffer (rx bos "*tide-"))

  (setq
    tide-format-options '(:indentSize 2 :tabSize 2))

;  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook
    'flycheck-mode-hook
    (lambda () (progn
                 (flycheck-add-mode 'typescript-tslint 'typescript-mode))))
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook 'init-programming-mode)
  (add-hook 'typescript-mode-hook 'tide-mode)
  (add-hook 'typescript-mode-hook 'company-mode))

(use-package
  web-mode
  :mode ("\\.tsx" . web-mode)
  :config

  (setq typescript-indent-level 2)
  (set-compile-for 'typescript-mode "yarn test")

  (use-package
    tide
    :ensure t
    :pin melpa-stable
    :config

    (add-hook 'typescript-mode-hook 'init-programming-mode)
    (add-hook 'typescript-mode-hook 'my/setup-tide)
    (add-hook 'typescript-mode-hook 'company-mode)))

(provide 'init-typescript)

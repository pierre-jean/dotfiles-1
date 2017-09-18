(pkg
  linum-relative
  :diminish linum-relative-mode
  :ensure t
  :config
  (linum-relative-global-mode)
  (setq
    linum-relative-current-symbol ""
    linum-relative-format "%3s ") ;; Add \u2502 for more separation

  (pkg
    git-gutter
    :ensure t
    :diminish 'git-gutter-mode
    :defer 0.5 ;; Fix for relative-line-number
    :config
    (global-git-gutter-mode t)
    (git-gutter:linum-setup)))

(provide 'relative-lines)

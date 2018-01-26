(require 'vim-mode)

;; Fixes Ansi colors on compilation buffer
(use-package ansi-color :ensure t :defer t)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
      compilation-filter-start (point))))

(add-hook 'compilation-filter-hook 'endless/colorize-compilation)
;TODO: (add-hook 'compilation-mode-hook 'evily/evilify-key-bindings)

(provide 'compile-mode)

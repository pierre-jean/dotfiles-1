(require 'init-programming-mode)

;;; Code:
(add-hook 'emacs-lisp-mode-hook 'programming-mode)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'flycheck-mode-hook
          (lambda () (add-to-list 'flycheck-disabled-checkers 'emacs-lisp-checkdoc)))

(provide 'init-el)

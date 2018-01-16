;; -*- lexical-binding: t -*-
(define-minor-mode
  programming-mode
  :lighter " λ"
  :group 'programming

  (require 'prettify)
  (require 'proper-gutter-mode)
  (require 'invisible-chars)
  (require 'syntax-check)
  (require 'rainbow-parenthesis)
  (require 'paren)
  (require 'compile)
  (require 'code-snippets)
  (require 'gotodefinition)
  (require 'init-documentation)
  (require 'init-code-folding)

  (setq show-paren-delay 0)

  (if programming-mode
    (progn
      (prettify-symbols-mode +1)
      (whitespace-mode +1)
      (proper-gutter-mode +1)
      (rainbow-delimiters-mode +1)
      (show-paren-mode +1)
      (yas-minor-mode +1)
      (flycheck-mode +1)
      (dumb-jump-mode +1)
      (origami-mode +1))
    (progn
      (prettify-symbols-mode -1)
      (whitespace-mode -1)
      (proper-gutter-mode -1)
      (rainbow-delimiters-mode -1)
      (show-paren-mode -1)
      (yas-minor-mode -1)
      (flycheck-mode -1)
      (dumb-jump-mode -1)
      (origami-mode -1))))

(defun set-compile-for (mode command)
  (add-hook mode
            (lambda ()
              (set (make-local-variable 'compile-command) command))))

(provide 'programming-mode)

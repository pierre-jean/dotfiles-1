(add-to-list 'load-path "~/Repositories/Haskell/structured-haskell-mode/elisp")
(require 'programming-mode)
(require 'shm)

(defun haskell/prettify ()
  (prettify
    '(
      ("forall" . ?∀)
      ("exists" . ?∃)

      ("->" . ?→)
      ("<-" . ?←)
      ("=>" . ?⇒)

      ("|->" . ?↦)
      ("<-|" . ?↤)

      ("~>" . ?⇝)
      ("<~" . ?⇜)

      (">->" . ?↣)
      ("<-<" . ?↢)

      ("not" . ?¬)
      ("&&" . ?∧)
      ("||" . ?∨)

      ("==" . ?≡)
      ("/=" . ?≠)
      ("<=" . ?≤)
      (">=" . ?≥)

      ("elem" . ?∈)
      ("notElem" . ?∉)
      ("member" . ?∈)
      ("notMember" . ?∉)
      ("union" . ?∪)
      ("intersection" . ?∩)
      ("isSubsetOf" . ?⊆)
      ("isProperSubsetOf" . ?⊂)

      ("<<" . ?≪)
      (">>" . ?≫)
      ("undefined" . ?⊥)
      ("\\" . ?λ))))


(use-package
  haskell-mode
  :ensure t
  :defer t
  :mode "\\.hs$"
  :config
  (use-package
    intero
    :ensure t
    :config
    (global-set-key (kbd "C-g") 'intero-goto-definition)
    (global-set-key (kbd "M-n") 'intero-highlight-uses-mode-next)
    (global-set-key (kbd "M-p") 'intero-highlight-uses-mode-prev)
    (global-set-key (kbd "ESC <f7>") 'intero-uses-at))

  (use-package company-ghci :ensure t :defer t)

  (custom-set-variables '(haskell-stylish-on-save f))
  (set-compile-for 'haskell-mode-hook "stack test")
  (add-hook 'haskell-mode-hook 'programming-mode)
  (add-hook 'haskell-mode-hook 'haskell/prettify)
  (add-hook 'haskell-mode-hook 'hs-doc)
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)
  (add-hook 'haskell-mode-hook 'intero-mode)
  (add-hook 'haskell-mode-hook 'structured-haskell-mode)
  (global-set-key (kbd "C-M-_") 'shm/add-operand)
  )


(defun hs-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Haskell")))

(provide 'haskell)

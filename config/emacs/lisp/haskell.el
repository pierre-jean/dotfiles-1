(add-to-list 'load-path "~/Repositories/Haskell/structured-haskell-mode/elisp")
(require 'programming-mode)
(require 'shm)

(defun haskell/prettify ()
  (prettify
    '(
      ;; Double-struck letters
      ("|A|" . ?𝔸)
      ("|B|" . ?𝔹)
      ("|C|" . ?ℂ)
      ("|D|" . ?𝔻)
      ("|E|" . ?𝔼)
      ("|F|" . ?𝔽)
      ("|G|" . ?𝔾)
      ("|H|" . ?ℍ)
      ("|I|" . ?𝕀)
      ("|J|" . ?𝕁)
      ("|K|" . ?𝕂)
      ("|L|" . ?𝕃)
      ("|M|" . ?𝕄)
      ("|N|" . ?ℕ)
      ("|O|" . ?𝕆)
      ("|P|" . ?ℙ)
      ("|Q|" . ?ℚ)
      ("|R|" . ?ℝ)
      ("|S|" . ?𝕊)
      ("|T|" . ?𝕋)
      ("|U|" . ?𝕌)
      ("|V|" . ?𝕍)
      ("|W|" . ?𝕎)
      ("|X|" . ?𝕏)
      ("|Y|" . ?𝕐)
      ("|Z|" . ?ℤ)
      ("|gamma|" . ?ℽ)
      ("|Gamma|" . ?ℾ)
      ("|pi|" . ?ℼ)
      ("|Pi|" . ?ℿ)

      ;; Quantifiers
      ("forall" . ?∀)
      ("exists" . ?∃)

      ;; Arrows
      ("->" . ?→)
      ("-->" . ?⟶)
      ("<-" . ?←)
      ("<--" . ?⟵)
      ("<->" . ?↔)
      ("<-->" . ?⟷)

      ("=>" . ?⇒)
      ("==>" . ?⟹)
      ("<==" . ?⟸)
      ("<=>" . ?⇔)
      ("<==>" . ?⟺)

      ("|->" . ?↦)
      ("|-->" . ?⟼)
      ("<-|" . ?↤)
      ("<--|" . ?⟻)

      ("|=>" . ?⤇)
      ("|==>" . ?⟾)
      ("<=|" . ?⤆)
      ("<==|" . ?⟽)

      ("~>" . ?⇝)
      ("<~" . ?⇜)

      (">->" . ?↣)
      ("<-<" . ?↢)
      ("->>" . ?↠)
      ("<<-" . ?↞)

      (">->>" . ?⤖)
      ("<<-<" . ?⬻)

      ("<|-" . ?⇽)
      ("-|>" . ?⇾)
      ("<|-|>" . ?⇿)

      ("<-/-" . ?↚)
      ("-/->" . ?↛)

      ("<-|-" . ?⇷)
      ("-|->" . ?⇸)
      ("<-|->" . ?⇹)

      ("<-||-" . ?⇺)
      ("-||->" . ?⇻)
      ("<-||->" . ?⇼)

      ("-o->" . ?⇴)
      ("<-o-" . ?⬰)

      ;; Boolean operators
      ("not" . ?¬)
      ("&&" . ?∧)
      ("||" . ?∨)

      ;; Relational operators
      ("==" . ?≡)
      ("/=" . ?≠)
      ("<=" . ?≤)
      (">=" . ?≥)
      ("/<" . ?≮)
      ("/>" . ?≯)

      ;; Containers / Collections
      ("elem" . ?∈)
      ("notElem" . ?∉)
      ("member" . ?∈)
      ("notMember" . ?∉)
      ("union" . ?∪)
      ("intersection" . ?∩)
      ("isSubsetOf" . ?⊆)
      ("isProperSubsetOf" . ?⊂)

      ;; Other
      ("<<" . ?≪)
      (">>" . ?≫)
      ("<<<" . ?⋘)
      (">>>" . ?⋙)
      ("<|" . ?⊲)
      ("|>" . ?⊳)
      ("><" . ?⋈)
      ("undefined" . ?⊥)
      (":=" . ?≔)
      ("=:" . ?≕)
      ("=def" . ?≝)
      ("=?" . ?≟)
      ("..." . ?…)
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

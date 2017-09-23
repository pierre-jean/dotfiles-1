(require 'prettify)
(require 'proper-gutter-mode)
(require 'invisible-chars)

(pkg
  haskell-mode
  :ensure t
  :config

  (pkg company-ghci :defer t)
  (custom-set-variables '(haskell-stylish-on-save t))
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

        ;; Types
        ("::" . ?∷)

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
        ("++" . ?⧺)
        ("+++" . ?⧻)
        ("|||" . ?⫴)
        ("empty" . ?∅)
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
        ("mempty" . ?∅)
        ("mappend" . ?⊕)
        ("<*>" . ?⊛)
        ("undefined" . ?⊥)
        (":=" . ?≔)
        ("=:" . ?≕)
        ("=def" . ?≝)
        ("=?" . ?≟)
        ("..." . ?…)
        ("\\" . ?λ))))
  (add-hook 'haskell-mode-hook 'whitespace-mode)
  (add-hook 'haskell-mode-hook 'prettify-symbols-mode)
  (add-hook 'haskell-mode-hook 'proper-gutter-mode)
  (add-hook 'haskell-mode-hook 'haskell/prettify))

(pkg
  intero
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

;; Zeal setup
(pkg zeal-at-point :ensure t)
(add-to-list 'zeal-at-point-mode-alist '(haskell-mode . "haskell"))
(global-set-key "\C-cd" 'zeal-at-point)
(add-to-list 'exec-path "/usr/bin/zeal")

(provide 'haskell)

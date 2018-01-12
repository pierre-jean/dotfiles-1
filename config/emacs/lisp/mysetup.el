;; Fonts
(defcustom my-font "xos4 Terminus" "Emacs font")
(defcustom my-font-height 150 "Emacs font height")

;; Themes
(defcustom available-themes '(nord spacemacs-light) "Available themes to cycle")
(pkg spacemacs-theme :ensure t :defer t)
(pkg
  nord-theme
  :ensure t
  :config
  (set-face-attribute 'vertical-border nil
                      :foreground "#EBCB8B") ; nord13
  )

(provide 'mysetup)

;; Fonts
(defcustom my-font "xos4 Terminus" "Emacs font")
(defcustom my-font-height 150 "Emacs font height")

;; Themes
(defcustom available-themes '(nord spacemacs-light) "Available themes to cycle")
(use-package spacemacs-theme :ensure t :defer t)
(use-package
  nord-theme
  :ensure t
  :config
  (set-face-attribute 'vertical-border nil
                      :foreground "#EBCB8B") ; nord13
;; configure smerge colors
 (add-hook 'smerge-mode-hook
 (lambda ()
   (set-face-background 'smerge-lower "green")
   (set-face-background 'smerge-markers "brightblack")
   (set-face-background 'smerge-upper "red"))))

(provide 'mysetup)

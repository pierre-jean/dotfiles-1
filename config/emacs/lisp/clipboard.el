(setq *is-a-mac* (eq system-type 'darwin))
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(defun copy-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
    (progn
      (cond
        ((and (display-graphic-p) x-select-enable-clipboard)
         (x-set-selection 'CLIPBOARD (buffer-substring (region-beginning) (region-end))))
        (t (shell-command-on-region (region-beginning) (region-end)
                                    (cond
                                      (*cygwin* "putclip")
                                      (*is-a-mac* "pbcopy")
                                      (*linux* "xsel -ib")))
           ))
      (message "Yanked region to clipboard!")
      (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))

(defun paste-from-x-clipboard()
  (interactive)
  (cond
    ((and (display-graphic-p) x-select-enable-clipboard)
     (insert (x-get-selection 'CLIPBOARD)))
    (t (shell-command
         (cond
           (*cygwin* "getclip")
           (*is-a-mac* "pbpaste")
           (t "xsel -ob"))
         1))
    ))

(define-key evil-motion-state-map (kbd "C-c") 'copy-to-x-clipboard)

(provide 'clipboard)

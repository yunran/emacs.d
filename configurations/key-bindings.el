;; All the key-bindings that I need to use
;; Copied from starter-kit

;;; For mac use mac-command-modifier to map command to meta
(setq mac-command-modifier 'meta)

;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Window switching. (C-x o goes to the next window)
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'shell)

;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(if (fboundp 'find-file-in-project)(global-set-key (kbd "C-x C-M-f") 'find-file-in-project))
(if (fboundp 'recentf-ido-find-file) (global-set-key (kbd "C-x f") 'recentf-ido-find-file))
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; pop mark
(global-set-key (kbd "M-j") 'pop-to-mark-command)

;; rgrep shortcut
(global-set-key (kbd "C-x r") 'rgrep)

;; paredit
(eval-after-load 'paredit
  '(define-key paredit-mode-map (kbd "C-o") 'paredit-open-round))

;;; Because C-M-t is taken by gnome-terminal in ubuntu, assigning C-S-t to it
;; (global-set-key (kbd "C-S-t") 'transpose-sexps)

(global-set-key (kbd "M-,") 'pop-tag-mark)
(global-set-key (kbd "M-*") 'tags-loop-continue)


;; End of key-bindings
(provide 'key-bindings)

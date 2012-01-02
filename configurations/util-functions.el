;; Utility Functions


;; Copied from CDK
;;settings for hippie-expand
(setq hippie-expand-try-functions-list
       '(yas/hippie-try-expand
         try-expand-dabbrev
         try-expand-dabbrev-from-kill
         try-expand-dabbrev-all-buffers
         try-complete-file-name-partially
         try-complete-file-name
         try-complete-lisp-symbol-partially
         try-complete-lisp-symbol))


;;function to implement a smarter TAB
(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
  the minibuffer. Else, if mark is active, indents region. Else if
  point is at the end of a symbol, expands it. Else indents the
  current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
	(hippie-expand nil))
    (if mark-active
	(indent-region (region-beginning)
		       (region-end))
      (if (looking-at "\\_>")
	  (hippie-expand nil)
	(indent-for-tab-command)))))
(global-set-key (kbd "TAB") 'smart-tab)

(when (executable-find "wmctrl") ; apt-get install wmctrl
  (defun full-screen-toggle ()
    (interactive)
    (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))
  (global-set-key (kbd "<M-return>") 'full-screen-toggle))


(defun pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(?\\(lambda\\>\\)"
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))
(add-hook 'python-mode-hook 'pretty-lambdas)

(defun turn-on-paredit ()
  (paredit-mode t))

;;End of the 
(provide 'util-functions)

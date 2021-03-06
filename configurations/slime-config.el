(require 'cl)
(require 'slime)

(defun turn-on-slime ()
  (slime-mode t))


(defun turn-on-slime-paredit ()
  "Redefining paredit-space-for-delimiter function so that paredit behaves
well in slime."
  (require 'paredit)
  (defun paredit-space-for-delimiter-p (endp delimiter)
    (and (not (if endp (eobp) (bobp)))
         (memq (char-syntax (if endp (char-after) (char-before)))
               (list ?\" ;; REMOVED ?w ?_
                     (let ((matching (matching-paren delimiter)))
                       (and matching (char-syntax matching)))))))
  (define-key slime-repl-mode-map
    (kbd "{") 'paredit-open-curly)
  (define-key slime-repl-mode-map
    (kbd "}") 'paredit-close-curly)
  (modify-syntax-entry ?\{ "(}")
  (modify-syntax-entry ?\} "){")
  (modify-syntax-entry ?\[ "(]")
  (modify-syntax-entry ?\] ")[")
  (modify-syntax-entry ?~ "'   ")
  (modify-syntax-entry ?, "    ")
  (modify-syntax-entry ?^ "'")
  (modify-syntax-entry ?= "'")
  (paredit-mode t))


(def-slime-selector-method ?j
  "Go to the most recently visited clojure-mode buffer."
  (slime-recently-visited-buffer 'clojure-mode))


(setq slime-net-coding-system 'utf-8-unix
      slime-protocol-version 'ignore)
(slime-setup '(slime-repl
               slime-scratch
               slime-editing-commands))

(add-hook 'lisp-mode-hook 'turn-on-slime)
(add-hook 'lisp-mode-hook 'turn-on-paredit)
(add-hook 'inferior-lisp-mode-hook 'turn-on-slime)
(add-hook 'slime-mode-hook 'turn-on-slime-paredit)
(add-hook 'slime-repl-mode-hook 'turn-on-slime-paredit)
(add-hook 'slime-connected-hook 'turn-on-slime-paredit)


(defadvice slime-repl-emit (after sr-emit-ad activate)
  (with-current-buffer (slime-output-buffer)
    (add-text-properties slime-output-start slime-output-end
                         '(font-lock-face slime-repl-output-face
                                          rear-nonsticky (font-lock-face)))))

(defadvice slime-repl-insert-prompt (after sr-prompt-ad activate)
  (with-current-buffer (slime-output-buffer)
    (let ((inhibit-read-only t))
      (add-text-properties slime-repl-prompt-start-mark (point-max)
                           '(font-lock-face slime-repl-prompt-face
                                            rear-nonsticky
                                            (slime-repl-prompt
                                             read-only
                                             font-lock-face
                                             intangible))))))


;;; Auto complete integration with slime
(progn
  (require 'ac-slime)
  (add-hook 'slime-mode-hook 'set-up-slime-ac))


(provide 'slime-config)

(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory (concat dotfiles-dir "/plugins/yasnippet-0.6.1/snippets"))
(yas/load-directory yas/root-directory)
(provide 'yasnippet-config)

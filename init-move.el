(require-package 'buffer-move)

(define-prefix-command 'ctl-x-m-map)
(global-set-key (kbd "C-x m") 'ctl-x-m-map)
(global-set-key (kbd "C-x m u") 'buf-move-up)
(global-set-key (kbd "C-x m d") 'buf-move-down)
(global-set-key (kbd "C-x m l") 'buf-move-left)
(global-set-key (kbd "C-x m r") 'buf-move-right)

(provide 'init-move)

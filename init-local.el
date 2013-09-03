
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-x/" 'help-command)
;(define-key global-map "\C-\M-x" 'eval-defun)
;(define-key global-map "\C-i" 'newline)
;; Setting English Font
(set-face-attribute
  'default nil :font "Consolas 10")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Microsoft Yahei" :size 14)))


(setq echo-keystrokes 0.1)
(setq default-major-mode 'text-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode -1)


(setq scroll-margin 3
      scroll-conservatively 10000)

(setq kill-do-not-save-duplicates t)
(menu-bar-mode -1)

(add-hook 'window-setup-hook 'maximize-frame t)

(provide 'init-local)


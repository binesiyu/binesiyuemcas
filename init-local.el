(define-key global-map "\C-h" 'delete-backward-char)
(define-key global-map "\C-x/" 'help-command)
(define-key global-map "\C-\M-x" 'eval-defun)
;(define-key global-map "\C-i" 'newline)
;; Setting English Font
(set-face-attribute
  'default nil :font "Consolas 10")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Microsoft Yahei" :size 12)))


(setq echo-keystrokes 0.1)
(setq default-major-mode 'text-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode -1)


(setq scroll-margin 3
      scroll-conservatively 10000)

(setq kill-do-not-save-duplicates t)

(provide 'init-local)
(menu-bar-mode -1)
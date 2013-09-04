
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

(defun yubin/split-window-v ()
  "show (other-buffer) in the new window"
  (funcall (split-window-func-with-other-buffer 'split-window-vertically)))


(defun yubin/split-window-h ()
  "show (other-buffer) in the new window"
 (funcall  (split-window-func-with-other-buffer 'split-window-horizontally)))

 (defun split-window-4()
 "Splite window into 4 sub-window"
 (interactive)
 (if (= 1 (length (window-list)))
     (progn (yubin/split-window-v)
            (yubin/split-window-h)
            (other-window 2)
            (yubin/split-window-h)
            )
   )
 )

;  +----------------------+                 +------------+-----------+
;  |                      |           \     |            |           |
;  |                      |   +-------+\    |            |           |
;  +----------+-----------+   +-------+/    |            +-----------+
;  |          |           |           /     |            |           |
;  |          |           |                 |            |           |
;  +----------+-----------+                 +------------+-----------+
(defun split-v-3 ()
  "Change 3 window style from horizontal to vertical"
  (interactive)

  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
            (let ((1stBuf (window-buffer (car winList)))
                  (2ndBuf (window-buffer (car (cdr winList))))
                  (3rdBuf (window-buffer (car (cdr (cdr winList))))))
              (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

              (delete-other-windows)
              (yubin/split-window-h)
              (set-window-buffer nil 1stBuf)
              (other-window 1)
              (set-window-buffer nil 2ndBuf)
              (yubin/split-window-v)
              (set-window-buffer (next-window) 3rdBuf)
              (select-window (get-largest-window))
            ))))

;  +------------+-----------+                  +----------------------+
;  |            |           |            \     |                      |
;  |            |           |    +-------+\    |                      |
;  |            +-----------+    +-------+/    +----------+-----------+
;  |            |           |            /     |          |           |
;  |            |           |                  |          |           |
;  +------------+-----------+                  +----------+-----------+


 (defun split-h-3 ()
  "Change 3 window style from vertical to horizontal"
  (interactive)

  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
            (let ((1stBuf (window-buffer (car winList)))
                  (2ndBuf (window-buffer (car (cdr winList))))
                  (3rdBuf (window-buffer (car (cdr (cdr winList))))))
                 (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

                 (delete-other-windows)
                 (yubin/split-window-v)
                 (set-window-buffer nil 1stBuf)
                 (other-window 1)
                 (set-window-buffer nil 2ndBuf)
                 (yubin/split-window-h)
                 (set-window-buffer (next-window) 3rdBuf)
                 (select-window (get-largest-window))
              ))))


;  +------------+-----------+                 +------------+-----------+
;  |            |           |            \    |            |           |
;  |            |           |    +-------+\   |            |           |
;  +------------+-----------+    +-------+/   +------------+           |
;  |                        |            /    |            |           |
;  |                        |                 |            |           |
;  +------------+-----------+                 +------------+-----------+
;  +------------+-----------+                 +------------+-----------+
;  |            |           |            \    |            |           |
;  |            |           |    +-------+\   |            |           |
;  |            +-----------+    +-------+/   +------------+-----------+
;  |            |           |            /    |                        |
;  |            |           |                 |                        |
;  +------------+-----------+                 +------------+-----------+

 (defun change-split-type-3 ()
  "Change 3 window style from horizontal to vertical and vice-versa"
  (interactive)

  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
            (let ((1stBuf (window-buffer (car winList)))
                  (2ndBuf (window-buffer (car (cdr winList))))
                  (3rdBuf (window-buffer (car (cdr (cdr winList)))))

                  (split-3
                   (lambda(1stBuf 2ndBuf 3rdBuf split-1 split-2)
                     "change 3 window from horizontal to vertical and vice-versa"
                     (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

                     (delete-other-windows)
                     (funcall split-1)
                     (set-window-buffer nil 2ndBuf)
                     (funcall split-2)
                     (set-window-buffer (next-window) 3rdBuf)
                     (other-window 2)
                     (set-window-buffer nil 1stBuf)))

                  (split-type-1 nil)
                  (split-type-2 nil)
                  )
              (if (= (window-width) (frame-width))
                  (setq split-type-1 'yubin/split-window-h
                        split-type-2 'yubin/split-window-v)
                (setq split-type-1 'yubin/split-window-v
                       split-type-2 'yubin/split-window-h))
              (funcall split-3 1stBuf 2ndBuf 3rdBuf split-type-1 split-type-2)

 ))))


;  +------------+-----------+                   +------------+-----------+
;  |            |     C     |            \      |            |     A     |
;  |            |           |    +-------+\     |            |           |
;  |     A      |-----------|    +-------+/     |     B      |-----------|
;  |            |     B     |            /      |            |     C     |
;  |            |           |                   |            |           |
;  +------------+-----------+                   +------------+-----------+
;
;  +------------------------+                   +------------------------+
;  |           A            |           \       |           B            |
;  |                        |   +-------+\      |                        |
;  +------------+-----------+   +-------+/      +------------+-----------+
;  |     B      |     C     |           /       |     C      |     A     |
;  |            |           |                   |            |           |
;  +------------+-----------+                   +------------+-----------+


  (defun roll-v-3 (&optional arg)
    "Rolling 3 window buffers (anti-)clockwise"
    (interactive "P")
    (select-window (get-largest-window))
    (if (= 3 (length (window-list)))
        (let ((winList (window-list)))
          (let ((1stWin (car winList))
                (2ndWin (car (cdr winList)))
                (3rdWin (car (last winList))))
            (let ((1stBuf (window-buffer 1stWin))
                  (2ndBuf (window-buffer 2ndWin))
                  (3rdBuf (window-buffer 3rdWin)))
              (if arg (progn
 ; anti-clockwise
                        (set-window-buffer 1stWin 3rdBuf)
                        (set-window-buffer 2ndWin 1stBuf)
                        (set-window-buffer 3rdWin 2ndBuf))
                (progn                                      ; clockwise
                  (set-window-buffer 1stWin 2ndBuf)
                  (set-window-buffer 2ndWin 3rdBuf)
                  (set-window-buffer 3rdWin 1stBuf))
                ))))))


(provide 'init-local)

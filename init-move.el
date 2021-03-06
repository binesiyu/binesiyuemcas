(require-package 'buffer-move)

(defun yubin/split-window-v ()
  "show (other-buffer) in the new window"
  (funcall (split-window-func-with-other-buffer 'split-window-vertically)))


(defun yubin/split-window-h ()
  "show (other-buffer) in the new window"
 (funcall  (split-window-func-with-other-buffer 'split-window-horizontally)))

 (defun split-window-4()
 "Splite window into 4 sub-window"
 (interactive)
 (if (< 1 (length (window-list)))
     (delete-other-windows))
 (if (= 1 (length (window-list)))
     (progn (yubin/split-window-v)
            (yubin/split-window-h)
            (other-window 2)
            (yubin/split-window-h)
            (other-window 2)
            )))

(defun split-window-3()
 "Splite window into 3 sub-window"
 (interactive)
 (if (< 1 (length (window-list)))
     (delete-other-windows))
 (if (= 1 (length (window-list)))
     (progn (yubin/split-window-h)
            (other-window 1)
            (yubin/split-window-v)
            (other-window 2)
            )))

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
                     (other-window 1)
                     (funcall split-2)
                     (set-window-buffer (next-window) 3rdBuf)
                     (other-window 1)
                     (set-window-buffer nil 1stBuf)))

                  (split-type-1 nil)
                  (split-type-2 nil)
                  )
              (if (>= 10 (- (frame-width) (window-width)))
                  (setq split-type-1 'split-window-horizontally
                        split-type-2 'split-window-vertically)
                (setq split-type-1 'split-window-vertically
                      split-type-2 'split-window-horizontally))
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
              (if (not arg) (progn
 ; anti-clockwise
                        (set-window-buffer 1stWin 3rdBuf)
                        (set-window-buffer 2ndWin 1stBuf)
                        (set-window-buffer 3rdWin 2ndBuf))
                (progn                                      ; clockwise
                  (set-window-buffer 1stWin 2ndBuf)
                  (set-window-buffer 2ndWin 3rdBuf)
                  (set-window-buffer 3rdWin 1stBuf))
                ))))))


(define-prefix-command 'ctl-x-m-map)
(global-set-key (kbd "C-x m") 'ctl-x-m-map)
(global-set-key (kbd "C-x m u") 'buf-move-up)
(global-set-key (kbd "C-x m d") 'buf-move-down)
(global-set-key (kbd "C-x m l") 'buf-move-left)
(global-set-key (kbd "C-x m r") 'buf-move-right)
(global-set-key (kbd "C-x m t") 'split-window-3)
(global-set-key (kbd "C-x m f") 'split-window-4)
(global-set-key (kbd "C-x m w") 'change-split-type-3)
(global-set-key (kbd "C-x m b") 'roll-v-3)



(provide 'init-move)

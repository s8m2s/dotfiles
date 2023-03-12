; Show line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))


(custom-set-variables

 ; Enable mouse mode
 '(xterm-mouse-mode t)

 )


;; use C-x for cut
;; C-c for copy
;; C-v for paste
(cua-mode 1)


;; move the current line up/down
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control meta shift up)]  'move-line-up)
(global-set-key [(control meta shift down)]  'move-line-down)

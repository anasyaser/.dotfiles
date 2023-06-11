(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(doom-gruvbox))
 '(custom-safe-themes
   '("944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" default))
 '(display-line-numbers 'relative)
 '(display-line-numbers-current-absolute t)
 '(display-line-numbers-type 'visual)
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-buffer-menu t)
 '(list-matching-lines-default-context-lines 1)
 '(package-selected-packages
   '(focus sideline-lsp crux helm-swoop expand-region ace-window flycheck corfu resize-window auctex-latexmk paredit org-modern pdf-tools latex-preview-pane preview-dvisvgm auctex sxhkdrc-mode multiple-cursors markdown-preview-eww pandoc-mode pandoc markdown-preview-mode impatient-mode projectile restart-emacs move-text rainbow-delimiters company magit avy ivy-rich ivy markdown-mode which-key-posframe doom-themes sml-mode spacemacs-theme evil gruvbox-theme whole-line-or-region which-key helm zenburn-theme))
 '(repeat-mode t))

(with-eval-after-load 'tex
  (setq TeX-source-correlate-method 'synctex)
  (TeX-source-correlate-mode)
  (setq TeX-source-correlate-start-server t)

  (add-to-list 'TeX-view-program-selection
               '(output-pdf "Zathura")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-[") 'tab-bar-history-back)
(global-set-key (kbd "M-]") 'tab-bar-history-forward)

;;(load-theme 'zenburn t)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c l") #'org-capture)
(require 'org)

(desktop-save-mode 1)

(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-creat-new-buffer 'always)
(put 'narrow-to-region 'disabled nil)

;; ================================================(Emacs in arabic tutorials)

;; -----------------------------Some Customization-------------------
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(delete-selection-mode 1)
(column-number-mode 1)

;;Using ibuffer to list all buffers instead of basic buffer
(global-set-key (kbd "C-x b") 'ibuffer)

;;Duplicate Current Line or Region
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))
      
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

;;Save all backup-files in one place
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backup-files/"))))

;;convert from vertical split to Horizontal Split
(defun toggle-window-split ()
(interactive)
(if (= (count-windows) 2)
(let* ((this-win-buffer (window-buffer))
(next-win-buffer (window-buffer (next-window)))
(this-win-edges (window-edges (selected-window)))
(next-win-edges (window-edges (next-window)))
(this-win-2nd (not (and (<= (car this-win-edges)
(car next-win-edges))
(<= (cadr this-win-edges)
(cadr next-win-edges)))))
(splitter
(if (= (car this-win-edges)
(car (window-edges (next-window))))
'split-window-horizontally
'split-window-vertically)))
(delete-other-windows)
(let ((first-win (selected-window)))
(funcall splitter)
(if this-win-2nd (other-window 1))
(set-window-buffer (selected-window) this-win-buffer)
(set-window-buffer (next-window) next-win-buffer)
(select-window first-win)
(if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)

;;Highlight Current Line
(global-hl-line-mode 1)


;;Auto close pair
(electric-pair-mode 1)

;;Don not close search when scroll
(setq isearch-allow-scroll t)

;;if there are lines continue to next line treat as separated line



(global-visual-line-mode 1)

;;babel configration
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (C . t)
   (calc . t)
   (latex . t)
   (java . t)
   (ruby . t)
   (lisp . t)
   (scheme . t)
   (shell . t)
   (sqlite . t)
   (js . t)))


(defun my-org-confirm-babel-evaluate (lang body)
  "Do not confirm evaluation for these languages."
  (not (or (string= lang "C")
           (string= lang "java")
           (string= lang "python")
           (string= lang "emacs-lisp")
           (string= lang "sqlite"))))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)



(setq c-default-style "bsd"
      c-basic-offset 8
      tab-width 8
      indent-tabs-mode t)
(require 'whitespace)
(setq whitespace-style '(face empty lines-tail trailing))
(global-whitespace-mode t)
(setq column-number-mode t)

;; inhibit splash screen
(setq inhibit-splash-screen t)

;; maximize screen on startup
;;(add-hook 'window-setup-hook 'toggle-frame--maximized t)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;(move-text-default-bindings)

;; <!-- language: lang-lisp -->

(defun markdown-html (buffer)
  (princ (with-current-buffer buffer
	   (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://ndossougbe.github.io/strapdown/dist/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
	 (current-buffer)))


(add-to-list 'load-path "~/.emacs.d/kbd-mode/")
(require 'kbd-mode)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(setq TeX-auto-save t)
(setq TeX-parse-self t)

(require 'org-tempo)
(require 'ox-md)
(require 'paredit)
(require 'ivy-rich)

(setq corfu-auto t
      corfu-auto-no-match 'separator)

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

(ivy-mode t)
(ivy-rich-mode 1)

(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(defvar aw-dispatch-alist
      '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?c aw-copy-window "Copy Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
      "List of actions for `aw-dispatch-default'.")



(fset 'cl0
   (kmacro-lambda-form [?\C-k ?\C-@ ?\C-s ?h ?3 ?\C-m ?\C-p ?\C-e ?\C-? ?\C-@ ?\C-s ?d ?i ?\C-m ?\C-a ?\C-@ ?\C-s ?T ?a ?s ?\C-m ?\C-e ?\C-? ?\C-s ?/ ?d ?i ?v ?\C-m ?\C-a ?\C-@ ?\C-s ?R ?e ?p ?\C-m ?\C-p ?\C-e ?\C-? ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n] 0 "%d"))


(setq x-select-enable-clipboard t)
(setq tty-setup-hook nil)

(global-set-key (kbd "C-<down>") (kbd "C-u 1 C-v"))
(global-set-key (kbd "C-<up>") (kbd "C-u 1 M-v"))


(defun st-set-window-title (&optional terminal)
      "Set the window title of the st TERMINAL.
The title is constructed from `frame-title-format'."
      (send-string-to-terminal
       (format "\e]0;%s\a" (format-mode-line frame-title-format))
       terminal))

(defun terminal-init-st ()
  "Terminal initialization function for st."
  (xterm-register-default-colors xterm-standard-colors)
  (tty-set-up-initial-frame-faces)
  (define-key input-decode-map "\e[1~" [home])
  (define-key input-decode-map "\e[4~" [end])
  (define-key input-decode-map "\e[J" [C-end])
  (define-key input-decode-map "\e[1;5F" [C-end])

  (define-key input-decode-map "\e[M" [C-delete])
  (define-key input-decode-map "\e[3;5~" [C-delete])

  (define-key input-decode-map "\e[5;5~" [C-prior])
  (define-key input-decode-map "\e[6;5~" [C-next])

  (define-key input-decode-map "\e[1;2A" [S-up])
  (define-key input-decode-map "\e[1;2B" [S-down])
  (define-key input-decode-map "\e[1;2C" [S-right])
  (define-key input-decode-map "\e[1;2D" [S-left])
  (define-key input-decode-map "\e[1;3A" [M-up])
  (define-key input-decode-map "\e[1;3B" [M-down])
  (define-key input-decode-map "\e[1;3C" [M-right])
  (define-key input-decode-map "\e[1;3D" [M-left])
  (define-key input-decode-map "\e[1;4A" [M-S-up])
  (define-key input-decode-map "\e[1;4B" [M-S-down])
  (define-key input-decode-map "\e[1;4C" [M-S-right])
  (define-key input-decode-map "\e[1;4D" [M-S-left])
  (define-key input-decode-map "\e[1;5A" [C-up])
  (define-key input-decode-map "\e[1;5B" [C-down])
  (define-key input-decode-map "\e[1;5C" [C-right])
  (define-key input-decode-map "\e[1;5D" [C-left])
  (define-key input-decode-map "\e[1;6A" [C-S-up])
  (define-key input-decode-map "\e[1;6B" [C-S-down])
  (define-key input-decode-map "\e[1;6C" [C-S-right])
  (define-key input-decode-map "\e[1;6D" [C-S-left])
  (define-key input-decode-map "\e[1;7A" [C-M-up])
  (define-key input-decode-map "\e[1;7B" [C-M-down])
  (define-key input-decode-map "\e[1;7C" [C-M-right])
  (define-key input-decode-map "\e[1;7D" [C-M-left])
  (define-key input-decode-map "\e[1;8A" [C-M-S-up])
  (define-key input-decode-map "\e[1;8B" [C-M-S-down])
  (define-key input-decode-map "\e[1;8C" [C-M-S-right])
  (define-key input-decode-map "\e[1;8D" [C-M-S-left])

  (st-set-window-title)
  (add-hook 'post-command-hook 'st-set-window-title)
  (add-hook 'minibuffer-exit-hook 'st-set-window-title))

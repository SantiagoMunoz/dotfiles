;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-agenda-files (quote ("~/org/personal.org" "~/org/airties/daytoday.org")))
 '(package-selected-packages
   (quote
    (jedi elpy use-package function-args evil-org powerline helm-gtags helm ggtags racer cargo ac-etags evil-magit rust-mode evil-tutor xcscope evil magit org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;;Helm
(require 'helm)
(require 'helm-config)
(helm-mode 1)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-actions)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;Helm gtags
(require 'helm-gtags)
(add-hook 'c-mode-hook 'helm-gtags-mode) 
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'rust-mode-hook 'helm-gtags-mode)

;;Show in which function we are
(add-hook 'c-mode-hook 'which-function-mode)

;;Key chords
(require 'key-chord)
(key-chord-mode 1)
(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-s") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

(define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
(define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
(define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
(define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)

(define-key helm-gtags-mode-map (kbd "M-i") 'helm-imenu)
;;Magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
;;Vi mode
(require 'evil)
(evil-mode 1)

;; Easy navigation between windows
(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

;;Alt-p/n to move pages up/down
(define-key evil-normal-state-map (kbd "M-p") (lambda ()
                    (interactive)
                    (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "M-n") (lambda ()
                        (interactive)
                        (evil-scroll-down nil)))

;; No backup files
(setq make-backup-files nil)

;; escape insert mode with jk drumroll
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

;;Folding on C files
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(key-chord-define evil-insert-state-map "za" 'hs-toggle-hiding)

;;evil magit
(require 'evil-magit)

;;Cscope
;;(require 'xcscope)
;;(cscope-setup)
;; evil cscope key configuration
;;(define-key evil-normal-state-map "-1" 'cscope-set-initial-directory)
;;(define-key evil-normal-state-map "-S" 'cscope-find-this-symbol)
;;(define-key evil-normal-state-map "-D" 'cscope-find-global-definition)
;;(define-key evil-normal-state-map "-g" 'cscope-find-this-text-string-no-prompting)
;;(define-key evil-normal-state-map "-G" 'cscope-find-this-text-string)
;;(define-key evil-normal-state-map "-f" 'cscope-find-this-file)
;;(define-key evil-normal-state-map "-u" 'cscope-pop-mark)
;;(define-key evil-normal-state-map "-c" 'cscope-find-functions-calling-this-function-no-prompting)
;;(define-key evil-normal-state-map "-C" 'cscope-find-functions-calling-this-function)
;;(define-key evil-normal-state-map "-t" 'cscope-display-buffer)
;;(define-key evil-normal-state-map "-j" 'my-semantic-jump)
;;(define-key evil-normal-state-map "-J" 'semantic-ia-fast-jump)
;;(define-key evil-normal-state-map "-r" 'semantic-symref)
;;(define-key evil-normal-state-map "-R" 'semantic-symref-symbol)

;; Cargo hook for rust (C-c C-c C-b and things like that)
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;;ggtags
;;(require 'ggtags)
;;(add-hook 'c-mode-common-hook
;;          (lambda ()
;;            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;              (ggtags-mode 1))))
;;
;;(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;;To have access to M-. which is taken by EVIL
(eval-after-load 'helm-gtags
  '(progn
     (evil-make-overriding-map helm-gtags-mode-map 'normal)
     ;; force update evil keymaps after ggtags-mode loaded
     (add-hook 'helm-gtags-mode-hook #'evil-normalize-keymaps)))

;;Powerline
(require 'powerline)
(powerline-default-theme)
(display-time-mode t)

;;Start Maximized


;; Smooth scrolling
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;;Show parent
(show-paren-mode t)

;;Remove scroll bar
(scroll-bar-mode -1)

;;Org mode stuff
(setq org-log-done t)

;;Rust 
(add-hook 'rust-mode-hook #'racer-mode)
;;(add-hook 'racer-mode-hook #'eldoc-mode)
(eval-after-load 'racer
  '(progn
     (evil-make-overriding-map racer-mode-map 'normal)
     ;; force update evil keymaps after ggtags-mode loaded
     (add-hook 'racer-mode-hook #'evil-normalize-keymaps)))

;;Python
(add-hook 'python-mode-hook 'jedi:setup)

;;Indent properly please
(define-key global-map (kbd "RET") 'newline-and-indent)
(require 'dtrt-indent)
(setq dtrt-indent-global-mote t)

;;C-style
(setq c-default-style "linux"
      c-basic-offset 8)

;; Start lisp mode automatically when opening a .clj file
(add-to-list 'auto-mode-alist (cons "\\.clj$" 'lisp-mode))

;; Load slime
(add-to-list 'load-path "/Users/john/src/slime/")
(require 'slime)
(slime-setup)

;; Load the clojure backend for slime
(add-to-list 'load-path "/Users/john/src/swank-clojure")
(setq swank-clojure-jar-path "/Users/john/src/clojure/clojure.jar")

;; Set up the Java classpath for clojure
(setq swank-clojure-extra-classpaths 
      (list "/Users/john/src/erayjure/commons-math-1.2/commons-math-1.2.jar"
	    "."))

(require 'swank-clojure-autoload)


(load "~/.emacs.d/vendor/haskell-mode/haskell-site-file")

;(load "~/.emacs.d/vendor/color-theme-6.6.0/color-theme.el")

;; Pretty colors
(load "~/.emacs.d/vendor/color-theme-6.6.0/themes/color-theme-library.el")
;;(color-theme-charcoal-black)
(color-theme-zenburn)

;; Haskell junk
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(defun my-haskell-mode-hook ()
  (global-set-key [(control c) (e)] 'inferior-haskell-reload-file))

;; Pretty / larger font
(set-face-font 'default "-apple-monaco-medium-r-normal--20-0-72-72-m-0-iso10646-1")

(setq erc-auto-query 'buffer)

(setq show-trailing-whitespace t)

;; Start the emacsclient server
(server-start)

;; Add column numbers to the status bar.
(column-number-mode)

;; Bind keys to make recording/recalling macros easier
(global-set-key (read-kbd-macro "A-M-m")
                'start-kbd-macro)

(global-set-key (read-kbd-macro "A-M-x")
                'call-last-kbd-macro)

;; Make alt be meta instead of command, so we can map command stuff to
;; normal cut and paste.
(setq mac-command-modifier 'alt
      mac-option-modifier 'meta)

;; Map command-x,c,v to cut, copy, paste
(global-set-key [?\A-x] 'clipboard-kill-region)
(global-set-key [?\A-c] 'clipboard-kill-ring-save)
(global-set-key [?\A-v] 'clipboard-yank)

;; More mac shortcuts.
(global-set-key [?\A-a] 'mark-whole-buffer)
(global-set-key [?\A-z] 'undo)
(global-set-key [?\A-l] 'goto-line)
(global-set-key [?\A-m] 'iconify-frame)
(global-set-key [?\A-n] 'new-frame)


;; Mozrepl stuffs

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'javascript-mode-hook 'java-custom-setup)
(defun javascript-custom-setup ()
  (moz-minor-mode 1))

;;(require 'moz)
;;(require 'json)
(load "~/.emacs.d/vendor/mozrepl/json.el")
 
(defun moz-update (&rest ignored)
  "Update the remote mozrepl instance"
  (interactive)
  (comint-send-string (inferior-moz-process)
    (concat "content.document.body.innerHTML="
             (json-encode (buffer-string)) ";")))
 
(defun moz-enable-auto-update ()
  "Automatically the remote mozrepl when this buffer changes"
  (interactive)
  (add-hook 'after-change-functions 'moz-update t t))
 
(defun moz-disable-auto-update ()
  "Disable automatic mozrepl updates"
  (interactive)
  (remove-hook 'after-change-functions 'moz-update t))

;; JDE Stuff
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/jde-2.3.5.1/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/cedet-1.0pre4/common/"))
(load-file (expand-file-name "~/.emacs.d/vendor/cedet-1.0pre4/common/cedet.el"))
(require 'jde)

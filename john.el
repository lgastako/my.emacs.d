(clojure-slime-config "/home/john/emacs-clojure")


;; Start clojure mode automatically when opening a .clj file
(add-to-list 'auto-mode-alist (cons "\\.clj$" 'clojure-mode))

;; Load slime
;;(add-to-list 'load-path "~john/src/slime/")
(require 'slime)
(slime-setup)

;; Load the clojure backend for slime
(add-to-list 'load-path "~john/src/swank-clojure")
(setq swank-clojure-jar-path "~john/src/clojure/clojure.jar")

;; YAML mode
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


;; Set up the Java classpath for clojure
(setq swank-clojure-extra-classpaths
      (list "~/.clojure"
            "~/src/clojure-contrib/clojure-contrib.jar"
            "~/src/erayjure/commons-math-1.2/commons-math-1.2.jar"
            "~/src/forex/dejcartes-snapshot/libs/jcommon-1.0.14.jar"
            "~/src/forex/dejcartes-snapshot/libs/jfreechart-1.0.11.jar"
            "~/src/forex/dejcartes-snapshot/dejcartes.jar"
	    "."))

(require 'swank-clojure-autoload)


(load "~/.emacs.d/vendor/haskell-mode/haskell-site-file")

;(load "~/.emacs.d/vendor/color-theme-6.6.0/color-theme.el")

;; Pretty colors
(load "~/.emacs.d/vendor/color-theme-6.6.0/themes/color-theme-library.el")
(load-file "~/.emacs.d/vendor/color-theme-6.6.0/themes/color-theme-railscasts.el")
;;(color-theme-charcoal-black)
;;(color-theme-zenburn)
(color-theme-railscasts)

;; yasnippets
(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;; emacs-textmate
;; (adds better ", ], \) etc pairing).
(load-file "~/.emacs.d/vendor/emacs-textmate/textmate.el")
(textmate-mode) ;; TODO: Should I add hooks? Nah, I want it on almost always...


;; Haskell junk
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(defun my-haskell-mode-hook ()
  (global-set-key [(control c) (e)] 'inferior-haskell-reload-file))

;; Pretty / larger font
;(set-face-font 'default "-apple-monaco-medium-r-normal--20-0-72-72-m-0-iso10646-1")
;(set-face-font 'default "Monaco_Linux")

(setq erc-auto-query 'buffer)

(setq show-trailing-whitespace t)
(setq-default show-trailing-whitespace t)

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

(defun javascript-custom-setup ()
  (moz-minor-mode 1))
(add-hook 'javascript-mode-hook 'javascript-custom-setup)


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
;;(setenv "JAVA_HOME"
;;        "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Sun-Repro")
;; Now overriden using customize..
;; (setq jde-jdk
;;"/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Sun-Repro")

;;;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/jde-2.3.5.1/lisp"))
;;;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/cedet-1.0pre4/common/"))
;;;;(load-file (expand-file-name "~/.emacs.d/vendor/cedet-1.0pre4/common/cedet.el"))
;;;;(require 'jde)


;; Ocaml stuff
(setq load-path (cons "~/.emacs.d/vendor/tuareg-mode-1.45.6/" load-path))

(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)


;; Prolog stuff
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
                                ("\\.m$" . mercury-mode))
                              auto-mode-alist))

;; Erlang stuff
;;(setq load-path (cons  "/opt/local/lib/erlang/lib/tools-2.6/emacs"
;;                       load-path))
;;(setq erlang-root-dir "/opt/local/lib/erlang")
;;(setq exec-path (cons "/opt/local/lib/erlang/bin" exec-path))
;;(require 'erlang-start)

;; No tabs damnit.
(setq indent-tabs-mode nil)


(setenv "PYTHONPATH" "/pluto/pluto:/pluto/pycloud")
(setenv "LD_LIBRARY_PATH" "/pluto/local/lib:/usr/local/lib")
(setenv "PATH" "/pluto/local/bin:/pluto/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games")

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/pluto/pycloud/apps/emacs/bin/lintrunner.py" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

(add-hook 'python-mode-hook (lambda() (flymake-mode t)))

;; Erlang
;;(setq load-path (cons  "/usr/share/emacs22/site-lisp/erlang/erlang"
;;                       load-path))
;;(setq erlang-root-dir "/usr")
;;(setq exec-path (cons "/usr/bin" exec-path))
;;(require 'erlang-start)

;;(setq ipython-command "/pluto/local/bin/ipython")
;;(load "~/.emacs.d/vendor/ipython.el")
;;(require 'ipython)

(load "~/go/misc/emacs/go-mode.el")


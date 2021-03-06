;;; custom-js-web.el --- Javascript and Web development customisation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Javascript (and Web) stuff:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Experiment: now that flycheck+jshint provides error checking, try
;;; the built in js-mode for a bit (it's already in auto-mode-alist):
;;; Code:

(setq js-indent-level 2)

;;; Work-around: the emacs version I'm using doesn't bundle
;;; json-pretty-print-buffer, used by restclient-mode.  So, implement
;;; it using json-reformat:
(after "restclient"
  (require 'json-reformat)
  (defun json-pretty-print-buffer ()
    (json-reformat-region (point-min) (point-max))))

;;; mozrepl integration
;;; (http://people.internetconnection.net/2009/02/interactive-html-development-in-emacs/):
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(after "moz"
  (require 'moz)
  (require 'json)
  (defun moz-update (&rest ignored)
    "Update the remote mozrepl instance"
    (interactive)
    (comint-send-string (inferior-moz-process)
                        (concat "content.document.body.innerHTML="
                                (json-encode (buffer-string)) ";")))
  (defun moz-enable-auto-update ()
    "Automatically update the remote mozrepl when this buffer changes"
    (interactive)
    (add-hook 'after-change-functions 'moz-update t t))
  (defun moz-disable-auto-update ()
    "Disable automatic mozrepl updates"
    (interactive)
    (remove-hook 'after-change-functions 'moz-update t)))

;;; From http://whattheemacsd.com//setup-html-mode.el-05.html
;;; after deleting a tag, indent properly (I didn't use
;;; sgml-delete-tag, but it's on C-c C-d)
(defadvice sgml-delete-tag (after reindent activate)
  (indent-region (point-min) (point-max)))

(autoload 'web-mode "web-mode"
  "Advanced combined mode for html-derived files" nil t)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;; emmet (zencoding) shortcuts for html generation:
(autoload 'emmet-mode "emmet-mode"
  "Emmet (Zencoding) HTML generation shortcuts" t)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(setq-default emmet-indentation 2)
;;; reclaim C-j keybinding from emmet!
(after "emmet-mode"
  (define-key emmet-mode-keymap (kbd "C-j") nil)
  (define-key emmet-mode-keymap (kbd "M-<return>") 'emmet-expand-line))

;;; Interactive django mode (virtualenv and fabric integration, etc):
;; Loading now then plugs it in to the related major-modes:

;;; Commentary:
;; 

(require 'pony-mode nil t)

;;; Make css colour definitions the colour they represent:
(autoload 'rainbow-turn-on "rainbow-mode" nil t)
(add-hook 'css-mode-hook 'rainbow-turn-on)

;;; use c-style indentation in css:
(setq cssm-indent-function 'cssm-c-style-indenter)

;;; Now using LessCSS, using its own derived mode:
(when (require 'less-css-mode nil t)
  (add-hook 'less-css-mode-hook 'rainbow-turn-on))

;;; JSX (React):
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Useful commands:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun url-decode-region (start end)
  "Replace a region with the same contents, only URL decoded."
  (interactive "r")
  (let ((text (url-unhex-string (buffer-substring start end))))
    (delete-region start end)
    (insert text)))

(defun url-encode-region (start end)
  "Replace a region with the same contents, only URL encoded."
  (interactive "r")
  (let ((text (url-hexify-string (buffer-substring start end))))
    (delete-region start end)
    (insert text)))

(provide 'custom-js-web)

;;; custom-js-web.el ends here

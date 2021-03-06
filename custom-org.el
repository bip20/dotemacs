;;; custom-org.el --- Org-mode Customisation

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode stuff:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Commentary:
;; 

;;; Code:

;;; don't bother eval-after-loading, because org is already included.
;;; We do however have to reload, so the local copy takes precedence
;;; over the distributed version:
(org-reload)
(setq org-directory (expand-file-name (file-name-as-directory "~/Dropbox/org"))

      org-log-done t

      ;; Some great tips from http://orgmode.org/worg/org-customization-guide.php
      org-special-ctrl-a/e t
      org-special-ctrl-k t		; behaviour of this is a bit subtle
      ;; (setq org-completion-use-ido t)

      ;; I'm using org for time-tracking now; just display hours, not days:
      ;; (see http://comments.gmane.org/gmane.emacs.orgmode/77120)
      org-time-clocksum-format "%d:%02d"

      ;; Be consistent with spacing between headings, even if already
      ;; on a new line:
      org-insert-heading-respect-content t

      ;; restore default value of the tags alignment column:
      org-tags-column -80

      ;; speed navigation commands:
      org-use-speed-commands t

      ;; automatically use symbols for \alpha, etc (toggle with C-c C-x \
      ;; if necessary):
      org-pretty-entities t)

;; Don't use agenda-cycle at the moment, so rebind C-, to my
;; scrolling commands:
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-,") 'scroll-up-one-line)))

;;; Bit of a hack to work around htmlize-buffer (as called by
;;; org-write-agenda for eg) not working.  See
;;; http://www.mail-archive.com/emacs-orgmode@gnu.org/msg04365.html
;;; and
;;; http://emacsbugs.donarmstrong.com/cgi-bin/bugreport.cgi?bug=648
(after "htmlize"
  (defadvice htmlize-faces-in-buffer (after org-no-nil-faces activate)
    "Make sure there are no nil faces"
    (setq ad-return-value (delq nil ad-return-value))))

;;; function to insert my workout template in workouts.org:
(defvar mh/workout-type-history-list nil)
(defun mh/org-new-workout (type)
  (interactive
   (list
    (read-string "Workout type: " nil 'mh/workout-type-history-list)))
  (if (and type
          (not (string= type "")))
      (let ((template
             "* %s %s
** Workout:
** Time taken =
** Heart-rate avg/max =
** Notes:"))
        (end-of-buffer)
        (unless (bolp) (newline))
        (insert (format template
                        (format-time-string "<%Y-%m-%d %a>")
                        type))
        ;; use org to do the tags, rather than trying to read them myself:
        (outline-up-heading 1)
        (org-set-tags)
        (end-of-line 2))
    (message "Aborted (no type specified)")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'custom-org)

;;; custom-org.el ends here

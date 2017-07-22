(setq config-packages
      '(
        (org :location built-in)
        worf
        ))

(defun config/post-init-org ()
  (setq org-directory "~/io"
        org-log-into-drawer 1
        org-default-notes-file (concat org-directory "/inbox.org")
        org-agenda-files (list org-directory (concat org-directory "/notes"))
        org-log-done t
        org-startup-with-inline-images t
        org-image-actual-width nil
        org-startup-indented t
        )

  ;; TODO Keywords
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
                )))

  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("IDEA" :foreground "red" :weight bold)
                ("NEXT" :foreground "deep sky blue" :weight bold)
                ("DRAFT" :foreground "deep sky blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "magenta" :weight bold)
                ("PUBLISHED" :foreground "forest green" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold))))

  ;; agenda
  (setq org-agenda-custom-commands
        (quote ((" " "Home"
                 ((agenda "" nil)
                  (todo "NEXT"
                        ((org-agenda-overriding-header "NEXT")))
                  (tags "draft"
                        ((org-agenda-overriding-header "WRITING")
                         (org-agenda-sorting-strategy '(todo-state-up))
                         ))
                  (tags-todo "PROJECT+TODO=\"TODO\""
                             ((org-agenda-overriding-header "PROJECTS")
                              (org-agenda-sorting-strategy '(todo-state-up))
                              ))
                  (tags-todo "NOTE+TODO=\"TODO\""
                             ((org-agenda-overriding-header "NOTES")
                              (org-agenda-sorting-strategy '(todo-state-up))
                              ))
                  (todo "WAITING|HOLD"
                        ((org-agenda-overriding-header "PENDING")
                         (org-agenda-sorting-strategy '(todo-state-up))
                         ))
                  ))
                ("w" "Writing"
                 ((agenda "")
                  (todo "DRAFT" ((org-agenda-overriding-header "Drafts")))
                  (todo "IDEA" ((org-agenda-overriding-header "Ideas"))))))))

  ;; archive
  (setq org-archive-mark-done nil)
  (setq org-archive-location "%s_archive::* Archived Tasks")

  ;; babel
  (require 'ob)
  (require 'ob-shell)
  (require 'ob-ruby)
  (require 'ob-python)
  (require 'ob-sass)
  (require 'ob-tangle)
  (setq org-src-fontify-natively t)
  (setq org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (emacs-lisp . t)
     (shell . t)
     (ruby . t)
     (sass . t)
     (dot . t)
     ))
  (defun org-babel-execute:yaml (body params) body)
  )

(defun config/init-worf ()
  (use-package worf
    :diminish worf-mode
    :after org)
  )

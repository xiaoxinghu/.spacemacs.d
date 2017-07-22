(defun config/recompile-elpa ()
  "Recompile packages in elpa directory. Useful if you switch
  Emacs versions."
  (interactive)
  (byte-recompile-directory package-user-dir nil t))

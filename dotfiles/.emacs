;;; OS integration of clipboard (paste).
(defun copy-from-osx ()
 (shell-command-to-string "pbpaste"))

;;; OS integration of clipboard (copy).
(defun paste-to-osx (text &optional push)
 (let ((process-connection-type nil))
     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
       (process-send-string proc text)
       (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;;; Don't create backup files (*.~). 
(setq make-backup-files nil)
;;; Don't create auto-save files (.#*).
(setq auto-save-default nil)

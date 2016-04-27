;;; geben-helm-projectile.el --- Integrate helm-projectile with geben.

;; Copyright (C) 2016  Free Software Foundation, Inc.

;; Author: Matthew Carter <m@ahungry.com>
;; Maintainer: Matthew Carter <m@ahungry.com>
;; URL: https://github.com/ahungry/geben-helm-projectile
;; Version: 0.0.1
;; Keywords: ahungry emacs geben helm projectile debug
;; Package-Requires: ((emacs "24") (geben "0.26") (helm-projectile "0.13.0"))

;; This file is not part of GNU Emacs.

;;; License:

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; helm-projectile integration for geben (in particular, opening files)

;; Make sure to include the project, then just run geben-helm-projectile/file
;; during an interactive geben session to open a file related to the project.

;;; News:

;;;; Changes since 0.0.0:
;; - Created the project

(eval-and-compile
  (require 'geben)
  (require 'helm-projectile))

(defvar geben-helm-projectile-version "0.0.1")

;;; Code:
(defun geben-helm-projectile/open-file (&optional arg)
  "Find a file in the current project using helm-projectile to open it.

Use a prefix ARG to force a cache refresh."
  (interactive "P")
    (geben-with-current-session session
      (cl-flet ((geben-open-file-fn
                 (file)
                 (geben-open-file (geben-source-fileuri session file))))
      (if (projectile-project-p)
          (projectile-maybe-invalidate-cache arg))
      (let ((helm-ff-transformer-show-only-basename nil)
            (my-sources helm-source-projectile-files-list)
            (file-path (file-name-directory
                        (replace-regexp-in-string "file:\/\/" ""
                        (geben-source-fileuri session (buffer-file-name))))))
	(when file-path
          (cd file-path))
        (add-to-list 'my-sources '(action ("Geben" . geben-open-file-fn)))
        (helm :sources my-sources
              :buffer "*helm projectile*"
              :prompt (projectile-prepend-project-name (if (projectile-project-p)
                                                           "pattern: "
                                                         "Switch to project: "))
              )))))

;;;###autoload
(when (and load-file-name (boundp 'load-path))
 (add-to-list
      'load-path
      (file-name-as-directory (file-name-directory load-file-name))))

(provide 'geben-helm-projectile)

;;; geben-helm-projectile.el ends here

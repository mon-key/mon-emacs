;; -*- mode: EMACS-LISP; no-byte-compile: t -*-

;;; ==============================
;;; :CREATED <Timestamp: #{2009-08-21T18:02:47-04:00Z}#{09345} - by MON KEY>
;;; :MODIFICATIONS <Timestamp: #{2010-04-06T12:11:52-04:00Z}#{10142} - by MON KEY>
;;; ==============================
(defun mon-map-elisp-fileset (&optional to-fileset-file insrtp intrp)
  "Return the list of *.el files in local Emacs load files.
Maps the values of follwing variables: 
 `*mon-emacs-root*', `*mon-naf-mode-root*', `*mon-ebay-tmplt-mode-root*'\n
When TO-FILESET-FILE is non-nil write the return value to the file named:
 \(concat *mon-naf-mode-root* \"/mon-elisp-fileset.el\")
When called-interactively or INSRTP is non-nil insert return value at point.
When INSRTP moves point. When called-interactively does not move point.
:EXAMPLE\n\n(mon-map-elisp-fileset)\n
:SEE-ALSO `*mon-el-library*'.\n▶▶▶"
  (interactive "i\ni\np")
  (let ((mmef (append (directory-files *mon-emacs-root* t ".*\.el$")
                      (directory-files *mon-naf-mode-root* t ".*\.el$")
                      (directory-files *mon-ebay-tmplt-mode-root* t ".*\.el$"))))
    (cond ((or insrtp intrp)
           (if intrp
               (save-excursion
                 (newline)
                 (princ (mapconcat 'identity mmef "\n") (current-buffer)))
               (progn
                 (newline)
                 (princ (mapconcat 'identity mmef "\n") (current-buffer)))))
          (to-fileset-file 
           (let ((mtef (concat *mon-naf-mode-root* "/mon-elisp-fileset.el")))
             (with-temp-file mtef
               (newline)
               (mapc #'(lambda (el-fl)
                         (prin1 el-fl (current-buffer))
                         (newline))
                     (append (directory-files *mon-emacs-root* t ".*\.el$")
                             (directory-files *mon-naf-mode-root* t ".*\.el$")
                             (directory-files *mon-ebay-tmplt-mode-root* t ".*\.el$"))))
             (with-current-buffer (find-file-noselect mtef t)
               (mon-file-stamp t)
               (write-file (buffer-file-name (current-buffer)))
               (kill-buffer (current-buffer)))))
          (t mmef))))
;;
;;; :TEST-ME (mon-map-elisp-fileset)
;;; :TEST-ME (mon-map-elisp-fileset t)
;;; :TEST-ME (mon-map-elisp-fileset nil t)

;;; ==============================
(provide mon-elisp-fileset)
;;; ==============================


;; Local Variables:
;; generated-autoload-file: "./mon-loaddefs.el"
;; no-byte-compile: t
;; coding: utf-8
;; mode: EMACS-LISP
;; End:

;;; ==============================
;;; EOF

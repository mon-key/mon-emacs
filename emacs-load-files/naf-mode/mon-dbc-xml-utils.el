;;; mon-dbc-xml-utils.el --- { A one line description of: mon-dbc-xml-utils. }
;; -*- mode: EMACS-LISP; -*-

;;; ================================================================
;; Copyright © 2011 MON KEY. All rights reserved.
;;; ================================================================

;; FILENAME: mon-dbc-xml-utils.el
;; AUTHOR: MON KEY
;; MAINTAINER: MON KEY
;; CREATED: 2011-01-07T16:02:29-05:00Z
;; VERSION: 1.0.0
;; COMPATIBILITY: Emacs23.*
;; KEYWORDS: 

;;; ================================================================

;;; COMMENTARY: 

;; =================================================================
;; DESCRIPTION:
;; mon-dbc-xml-utils provides { some description here. }
;;
;; FUNCTIONS:▶▶▶
;; `mon-dbc-xml-parse-clean-fields',
;; FUNCTIONS:◀◀◀
;;
;; MACROS:
;;
;; METHODS:
;;
;; CLASSES:
;;
;; CONSTANTS:
;;
;; FACES:
;;
;; VARIABLES:
;;
;; GROUPS:
;;
;; ALIASED/ADVISED/SUBST'D:
;;
;; DEPRECATED:
;;
;; RENAMED:
;;
;; MOVED:
;;
;; TODO:
;;
;; NOTES:
;;
;; SNIPPETS:
;;
;; REQUIRES:
;;
;; THIRD-PARTY-CODE:
;;
;; URL: http://www.emacswiki.org/emacs/mon-dbc-xml-utils.el
;; FIRST-PUBLISHED:
;;
;; EMACSWIKI: { URL of an EmacsWiki describing mon-dbc-xml-utils. }
;;
;; FILE-CREATED:
;; <Timestamp: #{2011-01-07T16:02:29-05:00Z}#{11015} - by MON KEY>
;;
;; =================================================================

;;; LICENSE:

;; =================================================================
;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;; =================================================================
;; Permission is granted to copy, distribute and/or modify this
;; document under the terms of the GNU Free Documentation License,
;; Version 1.3 or any later version published by the Free Software
;; Foundation; with no Invariant Sections, no Front-Cover Texts,
;; and no Back-Cover Texts. A copy of the license is included in
;; the section entitled ``GNU Free Documentation License''.
;; 
;; A copy of the license is also available from the Free Software
;; Foundation Web site at:
;; (URL `http://www.gnu.org/licenses/fdl-1.3.txt').
;;; ==============================
;; Copyright © 2011 MON KEY 
;;; ==============================

;;; CODE:

(eval-when-compile (require 'cl))

(unless (and (intern-soft "*IS-MON-OBARRAY*")
             (bound-and-true-p *IS-MON-OBARRAY*))
(setq *IS-MON-OBARRAY* (make-vector 17 nil)))


;;; ==============================
;;; :CHANGESET 2383
;;; :CREATED <Timestamp: #{2011-01-07T16:05:15-05:00Z}#{11015} - by MON KEY>
(defun mon-dbc-xml-parse-clean-fields (start end)
  "Transform XML schema from START to END into an intermediate format.\n
Used for annotating schemas prior converting to Common Lisp `defclass' forms.\n
Return value has the format:\n
 ;; :FIELD \"<FILEDNAME>\"
 ;;
 ;;         :TYPE \"<TYPE>\"
 ;;         :NULL-P \"<YES/NO>\"
 ;;         :KEY \"\"
 ;;         :DEFAULT \"\"
 ;;         :EXTRA \"\"
 ;;
 ;; :EXAMPLE-VALUES 
 ;;\n
:EXAMPLE\n\n
:SEE-ALSO .\n▶▶▶"
  (interactive "r")
  (unwind-protect
      (progn 
        (narrow-to-region start end)
        (dolist (r `(("^\\([[:blank:]]+\\)?<field Field=" . 
                      ,(concat "\n" (mon-comment-divider t) "\n;; :FIELD "))
                     ;; :NOTE (make-string (+ (length ":FIELD ") 2) 32) =>  "         "
                     ;; :WAS (" Type="    . "\n;;\n;;         :TYPE ")
                     (" Type="    . " :TRANSFORM\n;;\n;;         :TYPE ")
                     (" Null="    . "\n;;         :NULL-P ")
                     (" Key="     . "\n;;         :KEY ")
                     (" Default=" . "\n;;         :DEFAULT ")
                     (" Extra="   . "\n;;         :EXTRA ")
                     (" />$"      . "\n;;\n;; :EXAMPLE-VALUES \n;;\n;;\n;; -\n;;")))
          (mon-g2be -1)
          (while (search-forward-regexp (car r) nil t)
            (replace-match (cdr r)))))
    (widen)))

;;; ==============================
(provide 'mon-dbc-xml-utils)
;;; ==============================


;; Local Variables:
;; mode: EMACS-LISP
;; coding: utf-8
;; generated-autoload-file: "./mon-loaddefs.el"
;; End:

;;; ====================================================================
;;; mon-dbc-xml-utils.el ends here
;;; EOF

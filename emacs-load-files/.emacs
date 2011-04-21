;;; ~/.emacs  --- MON dot emacs 
;; -*- mode: EMACS-LISP; -*-

;;; ================================================================
;; Copyright © 2008-2011 MON KEY. All rights reserved.
;;; ================================================================

;; FILENAME: ~/.emacs
;; AUTHOR: MON KEY
;; MAINTAINER: MON KEY
;; CREATED: 2011-04-20T21:43:12-04:00Z
;; VERSION: 1.0.0
;; COMPATIBILITY: Emacs23.*
;; KEYWORDS: dotfile

;;; ================================================================

;;; COMMENTARY: 

;; =================================================================
;; DESCRIPTION:

;; MON .emacs provides load-paths/code specific to the site local Emacs 
;; allowing for for better portability/granularity across MON systems.
;;
;; Replace `<LOCAL-PATH-TO>' with a path appropriate to local system.
;; I use $DEVHOME 
;; Following enumerates what the `load'ed files referenced below do:
;;
;; - mon-site-local-defaults.el 
;; Where MON stores elisp that encapsulates private user data. 
;; This allows exposing more code in public forums:
;;
;; (load-file "<LOCAL-PATH-TO>/mon-site-local-defaults.el")
;;
;; - mon-default-loads.el
;; Bootstrap core load-paths.
;; The constants/variables established are needed across all MON systems.
;; 
;; (load-file "<LOCAL-PATH-TO>/mon-default-loads.el")
;;
;; - mon-default-start-loads.el
;; Finish loading required packages and site-local procedures.
;; The here routines are evaluated conditional to current MON system. 
;;
;; (load-file "<LOCAL-PATH-TO>/mon-default-start-loads.el")
;;
;;
;; PUBLIC-LINK: (URL `http://www.emacswiki.org/emacs/monDOTemacs.el)
;; FIRST-PUBLISHED: <Timestamp: #{2009-09-23T11:40:39-04:00Z}#{09393} - by MON>
;;
;; FILE-CREATED: Autumn 2008
;; HEADER-ADDED: <Timestamp: #{2009-09-23T11:29:10-04:00Z}#{09393} - by MON>
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
;; Copyright © 2008-2011 MON KEY 
;;; ==============================

;;; CODE:

(eval-when-compile (require 'cl))


(server-start)
;; (setq debug-on-error t) 

(setq init-file-user load-file-name)

(load (substitute-in-file-name "$DEVHOME/emacs-load-files/site-local-private.el"))

(load (substitute-in-file-name "$DEVHOME/emacs-load-files/mon-default-loads.el"))

(load (substitute-in-file-name "$DEVHOME/emacs-load-files/mon-default-start-loads.el"))


;;; ==============================
;; :NOTE getting at the TRUNK
;;
;; bzr checkout $DEVHOME/TRUNKS/emacs-load-files-BZR/trunk emacs-load-files-TRUNK
;;
;; bzr branch $DEVHOME/TRUNKS/emacs-load-files-TRUNK emacs-load-files
;;; ==============================

;;; ================================================================
;;; MON .emacs ends here
;;; EOF

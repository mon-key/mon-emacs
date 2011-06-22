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


(cd (getenv "HOME"))
;; (pwd)

(when (and (member "GDMSESSION=xfce" process-environment)
           (setq *mon-fixing-faces* t)
           (file-exists-p "emacs-environment"))
  (load (expand-file-name "emacs-environment") t nil t))


;; (URL `ftp://ftp.x.org/pub/DOCS/registry') 2001/06/01
;; (fontset-font "fontset-default"  9658)
;; (fontset-font "fontset-standard"  9658)
;; (fontset-font "fontset-startup"  9658)
;; :NOTE  `setup-default-fontset' is the guy finding mutt-clearlyu !
(when (string-equal (x-get-resource "emacs" "FontBackend") "x")
   (let ((props (font-face-attributes (x-get-resource "emacs" "font"))))
     (remf props :height)
     (setq props (apply #'font-spec :registry "iso10646-1" props))
     (set-fontset-font "fontset-standard"                    ;; t for "fontset-default"
                       (cons #x25b0 #x25bf) ;; <TARGET>
                       props                ;; <FONT-SPEC>
                       nil                  ;; <FRAME>
                       'append)))
  ;; (set-fontset-font "fontset-default"
  ;;                   'unicode-bmp
  ;;                   '("terminus" . "iso10646-1")))
  ;; (set-fontset-font "fontset-standard"
  ;;                   'unicode
  ;;                   '("terminus" . "iso10646-1"))

;; (set-fontset-font "fontset-default"                 ;; NAME
;;                   nil                               ;; TARGET
;;                   '("terminus" . "iso10646-1") ;; FONT-SPEC  (<FAMILY> . <REGISTRY>)
;;                   nil                               ;; FRAME
;;                   'prepend                          ;; ADD
;;                   )


;; make sure we're not driven crazy.
(blink-cursor-mode -1)


;;; ==============================
;;; :FRAME-PARAMETERS
;;; ==============================

;; :NOTE Following defaults are loaded after whatever is specified by the X
;; resources for the initial frame. IOW these only become active _during_ Emacs'
;; user specific initialization e.g. _after_ the creation of the initial frame. 
;; Inpsect documentation of `initial-frame-alist' for details.
;; :SEE struct `frame_parm_table' :FILE src/frame.c
;; :FILE src/xsettings.c src/xfns.c
;; :SEE-ALSO `x-get-resource', `x-parse-geometry', `frame-parameters',


;; `window-system-default-frame-alist'
(setq window-system-default-frame-alist
      '((x   (menu-bar-lines . 0) (tool-bar-lines   . 0))
        (nil (menu-bar-lines . 0) (tool-bar-lines   . 0))))
;;
(custom-note-var-changed 'window-system-default-frame-alist)

;; `default-frame-alist'
(setq default-frame-alist
      '((tool-bar-lines . 0)
        ;; (vertical-scroll-bar . nil)
        (vertical-scroll-bars)
        (background-color . "black")
        (background-mode . dark)
        (border-color . "black")
        (cursor-color . "yellow")
        (foreground-color . "white")
        (mouse-color . "white")
        (menu-bar-lines . 0)
        ))
;;
(custom-note-var-changed 'default-frame-alist)
;;
;; When they do become visible, put them on the right.
(setq default-frame-scroll-bars 'right)

;; initial-frame-alist
;;
;; display
;; top
;; font 
;; font-parameter
;; font-backend
;; wait-for-wm
;; font-backend
;; environment
;; 
;; minibuffer-frame-alist

;; x-gtk-use-old-file-dialog
;; (x-uses-old-gtk-dialog)
;; use-file-dialog
;; use-dialog-box
;; x-gtk-use-system-tooltips
;; x-gtk-whole-detached-tool-bar
;; gtk-version-string
;; (getenv "XENVIRONMENT")

(setq x-gtk-show-hidden-files t)
(custom-note-var-changed 'x-gtk-show-hidden-files)
;; :EXAMPLE (x-file-dialog "file" (file-name-as-directory (getenv "HOME")))

;;;;; 
;; (process-get server-process :server-file)
;; (getenv-internal "DISPLAY" (process-get server-process 'env))
;; (and server-use-tcp (process-get server-process :auth-key))
;; process-environment  initial-environment
;;;;;
(if (memq system-type (list 'gnu 'gnu/linux 'gnu/linux 'gnu/kfreebsd))
    ;;This won't work b/c server-socket-dir isn't in the environment yet!
    ;; (if (file-exists-p (expand-file-name "server" server-socket-dir))
    (if (file-exists-p (expand-file-name (format "/tmp/emacs%d/server" (truncate (user-uid)))))
	(let* ((catch-proc '())
	       (curr-comm invocation-name)
	       ;; :NOTE Neither of these work when emacs was initialized from an xdg session...
	       ;; (file-name-nondirectory  (getenv "_")) 
	       ;; (assoc-string  "_" initial-environment)
	       (match-comm (concat curr-comm ".*"))
	       (curr-pid (emacs-pid))
	       (curr-usr (truncate (user-uid)))) ;; (truncate (user-real-uid))
	  (dolist (proc-iter (list-system-processes)
			     (and catch-proc
				  (warn (concat "Declining to initialize a new server with `server-start'\n"
						"Found these existing server(s) already running:\n %S") catch-proc)))
	    (let* ((proc-att (process-attributes proc-iter))
		   (get-comm   (cdr (assq 'comm proc-att)))
		   (get-comm-if (and (string-match-p "emacs.*" get-comm) get-comm))
		   (get-pgrp   (and get-comm-if (cdr (assq 'pgrp proc-att))))
		   (get-pgrp-if (and get-pgrp
				     (unless (eq get-pgrp curr-pid)
				       get-pgrp)))
		   (get-euid (when get-pgrp-if
			       (cdr (assq 'euid proc-att))))
		   (get-euid-if (and (eq curr-usr get-euid) get-euid)))
	      (when (and get-euid-if (string-match-p match-comm get-comm-if)) ;; "<EMACS-?>.*"
		(unless (string-match-p "emacsclient.*" get-comm)
		  (push (list get-comm get-pgrp) catch-proc))))))
      (and (server-start) (server-mode t)))
  (unless server-running-p 
    (server-start) 
    (server-mode t)))

;; (setq debug-on-error t) 

(setq inhibit-default-init t)
(custom-note-var-changed 'inhibit-default-init)

(setq init-file-user load-file-name)

;; :WAS
;; (load (substitute-in-file-name "$DEVHOME/emacs-load-files/site-local-private.el"))
;; (load (substitute-in-file-name "$DEVHOME/emacs-load-files/mon-default-loads.el"))
;; (load (substitute-in-file-name "$DEVHOME/emacs-load-files/mon-default-start-loads.el"))

;; (getenv "LANG")
;; (getenv "USER")
;; (getenv "LOGNAME")
;; (user-original-login-name (user-real-uid))
(let* ((if-exists (getenv "DEVHOME"))
       (devhome (when if-exists
		  (substitute-in-file-name "${DEVHOME}/emacs-load-files/"))))
  (if (and devhome (file-exists-p devhome))
      (setq if-exists nil)
    (setq devhome nil))
  (if devhome
    (dolist (chk-name (list "site-local-private.el"
			    "mon-default-loads.el"
			    "mon-default-start-loads.el")
		      (when (and if-exists (eq (length if-exists) 3))
			(dolist (load-exist (nreverse if-exists))
			  (load load-exist))))
      (let ((chk-if (expand-file-name chk-name devhome)))
	;; This version takes care to ensure that we expanded into a file name 
	;; (if (and chk-if (not (string= devhome (file-name-as-directory chk-if))))	     
	(if (file-exists-p chk-if)
	    (push chk-if if-exists)
	  (setq if-exists nil))))
    (progn
      (set-scroll-bar-mode nil)
      (tool-bar-mode -1)
      (menu-bar-mode -1)
      (setq inhibit-startup-message t)
      ;; site-run-file ;; use --no-site-file
      ;; 
      ;; (executable-find "emacs")
    )))


;;; ==============================
;; :NOTE getting at the TRUNK
;;
;; bzr checkout $DEVHOME/TRUNKS/emacs-load-files-BZR/trunk emacs-load-files-TRUNK
;; bzr branch $DEVHOME/TRUNKS/emacs-load-files-TRUNK emacs-load-files
;;
;;; ==============================

;;; ================================================================
;;; MON .emacs ends here
;;; EOF

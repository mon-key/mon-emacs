;;; mon-cl-compat-regexps.el --- regexps and functions for matching symbols from cl pkgs
;; -*- mode: EMACS-LISP; -*-

;;; ================================================================
;; Copyright © 2010 MON KEY. All rights reserved.
;;; ================================================================

;; FILENAME: mon-cl-compat-regexps.el
;; AUTHOR: MON KEY
;; MAINTAINER: MON KEY
;; CREATED: 2010-01-17T02:42:34-05:00Z
;; VERSION: 1.0.0
;; COMPATIBILITY: Emacs23.*
;; KEYWORDS: lisp, development, Emacs, 

;;; ================================================================

;;; COMMENTARY: 

;; =================================================================
;; DESCRIPTION:
;; mon-cl-compat-regexps provides regular expressions for replacing the
;; symbol-names from the cl-seq.el package with a `cl::' prefix. These are
;; intended for use when with the mon-cl-compat.el package and allow for rapid
;; source transformation in packages which use: 
;;   (eval-when-compile (require 'mon-cl-compat))
;; to prevent Emacs compile time warnings w/re runtime calls to cl-*.el
;; functions. The variable `*regexp-clean-cl-symbols*' can be called
;; interactively as the argument to `mon-replace-region-regexp-lists' to
;; quickly adjust your Elisp source for use with mon-cl-compat.el.
;; 
;; All in all a sad state of affairs...
;;
;; The variable `*regexp-clean-cl-symbols*' holds a two keyed alist with associations
;; (:TO-COLON and :FROM-COLON) the cdr's of which contain lists of strings each
;; element a regexp and replacement pair that map from `symbol' -> `cl::symbol' and
;; `cl::symbol' -> `symbol' respectively. This allows for round tripping should
;; third parties wish to move the symbol back into the 'standard' Emacs cl
;; runtime namespace. The full set regexps are generated at loadtime and can be
;; regenereated by evaluating `mon-CL-cln-colon-swap' with `FORCED-COLONIC' t.
;; Regexp's wrapped in a match-grouping followed by the wsp-after-symbol
;; `\_>' and properly escape `*' suffixed cl symbols lest a regexp become too
;; greedy when matching. The ordering of the regexps have been formatted such
;; that larger symbols are matched before their smaller counter parts
;; e.g. they match/replace in this order:
;; cl-position :BEFORE position-if-not :BEFORE position-if :BEFORE position
;;
;; I'm reasonably confident that where a package has only 5-10 functions/macros
;; which rely on the 'runtime' functions from the cl*.el packages one can
;; simply:
;;  o Replace these with `cl::symbol' 
;;  o (eval-when-compile '(mon-cl-compat))
;;
;; The combined pair of packages mon-cl-compat.el and mon-cl-compat-regexps.el
;; is intended to provide a means for semi-automated source transformations for
;; moving the cl-*.el _functions_ into a namespace that won't cause the
;; byte-compiler to whine like a three year old whenever a `cl-*' function foo
;; is called at runtime. I'm adding symbols and regexps to these two packages
;; as the need arises. The downside to this approach is that it effectively
;; means that one is loading in _TWO_ emacs lisp cl compatibility environments
;; for each session... And really its four if your running slime and a real
;; CL...  Hence the rationale for choosing the `cl::' prefix is to allow for
;; increased potential for transforming Elisp to real Common-Lisp which is an
;; interesting pursuit explored in the inverse by both Clisp and more recently
;; Guile 1.8+ (i.e. post 2009-11).
;; 
;; No doubt I've approached this hastily and far greater minds have achieved a
;; better methods of integration. For an example (of which I'm completely
;; unable to grok but which makes sense in small doses) take a gander at the
;; venerable Pascal Bourguignon's Common-Lisp -> Emacs Lisp compatibility
;; procedures in the ../lisp and ../emacs subdirs at:
;; :SEE (URL `http://darcs.informatimago.com/local/darcs/public/')
;;
;; FUNCTIONS:▶▶▶
;; `mon-CL-namespace-colonic', `mon-CL-cln-colon-swap',
;; `mon-CL-escape-star', `mon-CL-escape-regexp',
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
;; `*regexp-clean-cl-symbols*', `*clean-cl-symbols-with-regexp*'
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
;; NOTES: When adding symbols to this the variable `*regexp-clean-cl-symbols*' in
;; order to prevent inadverdently replacing strings to soon and thereby
;; clobbering or otherwise doubling subportions of a symbol name it is necesary
;; to ensure that elts of regexp list are given in most -> least specific
;; order. IOW, where a symbol is prefixed by the name of another like symbol
;; with a suffix, the longer suffixed symbol must come before the shorter
;; prefixed symbol:
;; 
;;  ("remove-if-not" "cl::remove-if-not") ; :BEFORE `remove-if'
;;  ("remove-if" "cl::remove-if")         ; :AFTER `remove-if-not'
;;
;; Likewise, some symbols are prefixed with `cl-' these follow the same rule:
;;
;;  ("cl-position" "cl::cl-position")    ; :BEFORE `position'  
;;  ("position"   "cl::position")        : :AFTER `cl-position'
;; 
;; Be careful with the destrucive symbols `nSYMBOL'. These need to appear
;; before there non-destructive counterparts.
;;
;; :NOTE when evaluating these regexps programatiaclly wrap in a:
;; (with-syntax-table emacs-lisp-mode-syntax-table ...BODY... )
;;
;; :NOTE The variable `byte-compile-cl-functions' returns the list of 
;; functions defined in CL.
;; :SEE-ALSO `byte-compile-find-cl-functions', `byte-compile-cl-warn'
;; `byte-compile-disable-warning', `byte-compile-disable-warning',
;; `byte-compile-warning-enabled-p', `byte-compile-warnings',
;; `byte-compile-warning-types', `byte-compile-file-form-require',
;; :SEE :FILE bytecomp.el bytecomp.c
;;
;; SNIPPETS:
;;
;; REQUIRES:
;;
;; THIRD-PARTY-CODE:
;;
;; URL: http://www.emacswiki.org/emacs/mon-cl-compat-regexps.el
;; FIRST-PUBLISHED: <Timestamp: #{2010-01-17T23:06:27-05:00Z}#{10027} - by MON>
;;
;; EMACSWIKI: { URL of an EmacsWiki describing mon-cl-compat-regexps. }
;;
;; FILE-CREATED:
;; <Timestamp: #{2010-01-17T02:42:34-05:00Z}#{10027} - by MON>
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
;; Copyright © 2010 MON KEY 
;;; ==============================

;;; CODE:

(eval-when-compile (require 'cl))

;;; ==============================
;;; :CREATED <Timestamp: #{2010-01-20T15:26:28-05:00Z}#{10033} - by MON KEY>
(defvar *regexp-clean-cl-symbols* nil
  "*An alist of repexp pairs for use with `mon-replace-region-regexp-lists'.\n
Regexp pairs generated from list elements of `*clean-cl-symbols-with-regexp*'.\n
List contains the association keys :TO-COLON and :FROM-COLON.\n
List alements associated with the :TO-COLON key have the form:\n
\(:TO-COLON
  \(\"\\\\\(symbol\\\\\)\\\\_>\" \"cl::symbol\"\)
  \(\"\\\\\(symbol\\\\*\\\\\)\\\\_>\" \"cl::symbol*\"\)
   ... \)\n
List alements assocated with the :FROM-COLON key have the form:\n
\(:FROM-COLON
  \(\"\\\\\(cl::symbol\\\\\)\\\\_>\" \"symbol\"\)
  \(\"\\\\\(cl::symbol\\\\*\\\\\)\\\\_>\" \"symbol*\"\)
   ... \)\n
The cdrs of keyed associations into this variable are used with regexp
looping procedures, e.g. as an argument to `mon-replace-region-regexp-lists'
which when called-interactively can quickly adjust elisp source for use with:
:FILE mon-cl-compat.el\n
:EXAMPLE\n\n\(cadr \(assoc :FROM-COLON *regexp-clean-cl-symbols*\)\)\n
\(cadr \(assoc :TO-COLON *regexp-clean-cl-symbols*\)\)\n
To edit or add additional regexps to this variable adjust the list in the
`*clean-cl-symbols-with-regexp*' variable (re)bind it using setq and 
\(re\)evaluate `mon-CL-cln-colon-swap' with the true FORCED-COLONIC argument e.g.:\n
\(mon-CL-cln-colon-swap t\)\n
:NOTE Eventually this list should incorporate all elts from:
:VARIABLE `byte-compile-cl-functions'.\n
:SEE-ALSO  `mon-CL-escape-star', `mon-CL-escape-regexp',
`mon-CL-namespace-colonic', `byte-compile-cl-file-p',
`byte-compile-find-cl-functions', `byte-compile-cl-warn'.\n▶▶▶")
;;
;;; :TEST-ME *regexp-clean-cl-symbols*
;;
;;;(progn (makunbound '*regexp-clean-cl-symbols*)
;;;       (unintern '*regexp-clean-cl-symbols*) ) 

;;; ==============================
;;; :NOTE Regexps generated programtically with list below at loadtime.
;;; :CREATED <Timestamp: #{2010-01-17T16:51:22-05:00Z}#{10027} - by MON KEY>
(defvar *clean-cl-symbols-with-regexp*
  ;; :CL-SEQ-VARIABLES
  '(("cl-test-not"          "cl::test-not")
    ("cl-test"              "cl::test")
    ;;
    ("cl-if-not"            "cl::if-not")
    ("cl-if"                "cl::if")
    ;;
    ("cl-alist"             "cl::alist")
    ;; :NOTE The symbol `cl-key' is a special case. 
    ;; It mustn't fail b/c `cl-keys' is used  everywhere.
    ;; :WAS ("cl-key[^s]"          "cl::key")    
    ("cl-key"               "cl::key")
    ;; :CL-SEQ-MACROS
    ("cl-parsing-keywords"  "cl::parsing-keywords")
    ("cl-check-key"         "cl::check-key")
    ("cl-check-test-nokey"  "cl::check-test-nokey")
    ("cl-check-test"        "cl::check-test")
    ("cl-check-match"       "cl::check-match")
    ;; :CL-SEQ-FUNCTIONS
    ("reduce"               "cl::reduce")
    ("fill"                 "cl::fill")
    ("replace"              "cl::replace")
    ;;
    ("remove-duplicates"    "cl::remove-duplicates")
    ("remove-if-not"        "cl::remove-if-not")
    ("remove-if"            "cl::remove-if")
    ("remove*"              "cl::remove")
    ;;
    ("cl-delete-duplicates" "cl::cl-delete-duplicates")
    ("delete-duplicates"    "cl::delete-duplicates")
    ;;
    ("delete-if-not"        "cl::delete-if-not")
    ("delete-if"            "cl::delete-if")
    ("delete*"              "cl::delete*")
    ;;
    ("nsubstitute-if-not"   "cl::nsubstitute-if-not")
    ("nsubstitute-if"       "cl::nsubstitute-if")
    ("nsubstitute"          "cl::nsubstitute")
    ;;
    ("substitute-if-not"    "cl::substitute-if-not")
    ("substitute-if"        "cl::substitute-if")
    ("substitute"           "cl::substitute")
    ;;
    ("find-if-not"          "cl::find-if-not")
    ("find-if"              "cl::find-if")
    ("find"                 "cl::find")
    ;;
    ("cl-position"          "cl::cl-position")
    ("position-if-not"      "cl::position-if-not")
    ("position-if" 	    "cl::position-if")
    ("position"             "cl::position")
    ;;
    ("count-if-not"         "cl::count-if-not")
    ("count-if"             "cl::count-if")
    ("count"                "cl::count")
    ;;
    ("mismatch"             "cl::mismatch")
    ;;
    ("search"               "cl::search")
    ;;
    ("stable-sort"          "cl::stable-sort")
    ("sort*"                "cl::sort*")
    ;;
    ("merge"                "cl::merge")
    ;;
    ("member-if-not"        "cl::member-if-not")
    ("member-if"            "cl::member-if")
    ("member*"              "cl::member*")
    ("cl-member"            "cl::cl-member")
    ;;
    ("cl-adjoin"            "cl::cl-adjoin")
    ;;
    ("rassoc-if-not"        "cl::rassoc-if-not")
    ("rassoc-if"            "cl::rassoc-if")
    ("rassoc*"              "cl::rassoc*")
    ;;
    ("assoc-if-not"         "cl::assoc-if-not")
    ("assoc-if"             "cl::assoc-if")
    ("assoc*"               "cl::assoc*")
    ;;
    ("nunion"               "cl::nunion")
    ("union"                "cl::union")
    ;;
    ("nintersection"        "cl::nintersection")
    ("intersection"         "cl::intersection")
    ;;
    ("nset-difference"      "cl::nset-difference")
    ("set-difference"       "cl::set-difference")
    ;;
    ("nset-exclusive-or"    "cl::nset-exclusive-or")
    ("set-exclusive-or"     "cl::set-exclusive-or")
    ;;
    ("subsetp"              "cl::subsetp")
    ;;
    ("nsubst-if-not"        "cl::nsubst-if-not")
    ("nsubst-if"            "cl::nsubst-if")
    ("nsubst"               "cl::nsubst")
    ;;
    ("subst-if-not"         "cl::subst-if-not")
    ("subst-if"             "cl::subst-if")
    ;;
    ("cl-do-subst" "cl::cl-do-subst")
    ("subst"       "cl::subst")
    ;;
    ("cl-nsublis-rec"       "cl::cl-nsublis-rec")
    ("nsublis"              "cl::nsublis")
    ;;
    ("cl-sublis-rec"        "cl::cl-sublis-rec")
    ("sublis"               "cl::sublis")
    ;;
    ("cl-tree-equal-rec"    "cl::cl-tree-equal-rec")
    ("tree-equal"           "cl::tree-equal")
    ;;
    ;; :CL-MACS.el
    ;; cl::cl-transform-function-property
    ;; cl::cl-transform-lambda
    ;; cl-do-arglist   cl::cl-do-arglist
    ;; cl-arglist-args cl::cl-arglist-args
    ;; cl-compile-time-too cl::cl-compile-time-too
    ;; cl::cl-byte-compile-block
    ;; cl::cl-byte-compile-throw
    ("cl-defun-expander"    "cl::cl-defun-expander")     ;; <- cl-macs.el
    ("cl-simple-expr-p"     "cl::cl-simple-expr-p")      ;; <- cl-macs.el
    ("cl-simple-exprs-p"    "cl::cl-simple-exprs-p")     ;; <- cl-macs.el
    ("cl-safe-expr-p"       "cl::cl-safe-expr-p")        ;; <- cl-macs.el
    ("cl-const-exprs-p"     "cl::cl-const-exprs-p")      ;; <- cl-macs.el
    ("cl-const-expr-p"      "cl::cl-const-expr-p")       ;; <- cl-macs.el
    ("cl-const-expr-val"    "cl::cl-const-expr-val")     ;; <- cl-macs.el
    ("cl-expr-access-order" "cl::cl-expr-access-order")  ;; <- cl-macs.el
    ("cl-expr-contains"     "cl::cl-expr-contains")      ;; <- cl-macs.el
    ("cl-expr-contains-any" "cl::cl-expr-contains-any")  ;; <- cl-macs.el
    ("cl-expr-depends-p"    "cl::cl-expr-depends-p")     ;; <- cl-macs.el
    ("cl-defsubst-expand"   "cl::cl-defsubst-expand")    ;; <- cl-macs.el

    ("gensym"               "cl::gensym")    ;; <- cl-macs.el
    ("gentemp"              "cl::gentemp")   ;; <- cl-macs.el

    ("compiler-macroexpand" 
       "cl::compiler-macroexpand")           ;; <- cl-macs.el
    ("cl-byte-compile-compiler-macro" 
       "cl::cl-byte-compile-compiler-macro") ;; <- cl-macs.el

    ("cl-make-type-test"    "cl::cl-make-type-test")    ;; <- cl-macs.el
    ("typep"                "cl::typep")                ;; <- cl-macs.el

    ;; :CL-EXTRA.el
    ("cl-remprop"  "cl::cl-remprop")        ;; <- cl-extra.el
    ("cl-do-remf"  "cl::cl-do-remf")        ;; <- cl-extra.el
    ("subseq"      "cl::subseq")            ;; <- cl-extra.el
    ("coerce"      "cl::coerce")            ;; <- cl-extra.el
    ("ceiling*"    "cl::ceiling*")          ;; <- cl-extra.el
    ("floor*"      "cl::floor*")            ;; <- cl-extra.el
    ("isqrt"       "cl::isqrt")             ;; <- cl-extra.el
    ("maplist"     "cl::maplist")           ;; <- cl-extra.el
    ("mod*"        "cl::mod*")              ;; <- cl-extra.el
    ("rem*"        "cl::rem*")              ;; <- cl-extra.el
    ("round*"      "cl::round*")            ;; <- cl-extra.el
    ("signum"      "cl::signum")            ;; <- cl-extra.el
    ("truncate*"   "cl::truncate*")         ;; <- cl-extra.el
    ;; :NOTE should prob. be careful with these three letter symbols.
    ("gcd"         "cl::gcd")                        ;; <- cl-extra.el
    ("lcm"         "cl::lcm")                         ;; <- cl-extra.el

    ;; :CL-*.EL-FUNCTIONS
  ("cl-mapcar-many"       "cl::cl-mapcar-many")   ;; <- cl-extra.el
  ("list*"                "cl::list*")            ;; <- cl.el
  ("mapcar*"              "cl::mapcar*")          ;; <- cl.el
  ("acons"                "cl::acons")            ;; <- cl.el
  ("copy-list"            "cl::copy-list")        ;; <- cl.el
  ("cl-random-time"       "cl::cl-random-time")   ;; <- cl.el
  ("ldiff"                "cl::ldiff")            ;; <- cl.el
  ("pairlis"              "cl::parilis")          ;; <- cl.el
  ("floatp-safe"          "cl::floatp-safe")      ;; <- cl.el
  ("plusp"                "cl::plusp")            ;; <- cl.el
  ("minusp"               "cl::minusp")           ;; <- cl.el
  ("oddp"                 "cl::oddp")             ;; <- cl.el
  ("evenp"                "cl::evenp")            ;; <- cl.el
  )
  "*A list of string pairs to generate regexps for cl symbol transformation.\n
Regexps generated with `mon-CL-escape-star', `mon-CL-escape-regexp' 
`mon-CL-cln-colon-swap', `mon-CL-namespace-colonic', are held in the
:VARIABLE `*regexp-clean-cl-symbols*'\n
Elements of list have the form:\n
 \(\"symbol\" \"cl::symbol\"\)\n
:NOTE To prevent inadvertently replacing strings too soon, thereby clobbering or
otherwise doubling sub portions of a symbol name, it is necessary to ensure that
elts of regexp list are given in most -> leas specific order. IOW, where a
symbol is prefixed by the name of another like symbol with a suffix, the longer
suffixed symbol must come before the shorter prefixed symbol:\n
 \(\"remove-if-not\" \"cl::remove-if-not\"\) ; :BEFORE `remove-if'
 \(\"remove-if\" \"cl::remove-if\"\)         ; :AFTER  `remove-if-not'\n
Likewise, some symbols are prefixed with `cl-' these follow the same rule:\n
 \(\"cl-position\" \"cl::cl-position\"\)     ; :BEFORE `position'
 \(\"position\"   \"cl::position\"\)         : :AFTER  `cl-position'\n
Be careful with the destrucive symbols `nSYMBOL'. These need to appear
before there non-destructive counterparts.\n
:NOTE Eventually this list should incorporate all elts from:
:VARIABLE `byte-compile-cl-functions'.\n
:SEE-ALSO `mon-replace-region-regexp-lists', `byte-compile-find-cl-functions',
`byte-compile-cl-warn', `byte-compile-cl-file-p'.\n▶▶▶")
;;
;;; :TEST-ME *clean-cl-symbols-with-regexp*
;;
;;;(progn (makunbound '*clean-cl-symbols-with-regexp*)
;;;       (unintern '*clean-cl-symbols-with-regexp*) ) 

;;; ==============================
;;; :NOTE Clobbers "cl-keys[^s]" 
;;; :TODO figure out how we wanna handle "[^s]" etc.
;;; :CREATED <Timestamp: #{2010-01-20T13:54:06-05:00Z}#{10033} - by MON>
(defun mon-CL-escape-star (star-string-maybe &optional has-colon)
  "Return escaped string STAR-STRING-MAYBE if it contains an asterisk.\n
When optional arg HAS-COLON is non-nil match strings prefixed by `cl::'.\n
Return values are as follows:\n
\"cl-symbol\"      -> \"cl-symbol\"
\"cl-symbol*\"     -> \"cl-symbol\\\\*\" 
\"cl::cl-symbol\"  -> \"cl::cl-symbol\"
\"cl::cl-symbol*\" -> \"cl::cl-symbol\\\\*\"\n
:EXAMPLE\n\n\(mon-CL-escape-star \"cl-symbol\"\)
\(mon-CL-escape-star \"cl-symbol*\"\)
\(mon-CL-escape-star \"cl::cl-symbol\" t\)
\(mon-CL-escape-star \"cl::cl-symbol*\" t\)\n
:SEE-ALSO `mon-CL-escape-regexp', `mon-CL-namespace-colonic',
`mon-CL-cln-colon-swap', `*regexp-clean-cl-symbols*',
`*clean-cl-symbols-with-regexp*', `byte-compile-cl-functions',
`byte-compile-find-cl-functions', `byte-compile-cl-warn',
`byte-compile-cl-file-p'.\n▶▶▶"
  (let ((star-test '("[a-z-]+\\*" . "cl::[a-z-]+\\*"))
        (star-rep  '("\\([a-z-]+\\)\\(\\*\\)"
                     . "\\(cl::[a-z-]+\\)\\(\\*\\)"))
        transd)
    (if (string-match-p 
         (if has-colon 
             (cdr star-test)
             (car star-test))
         star-string-maybe)
        (setq transd (replace-regexp-in-string 
                      (if has-colon (cdr star-rep) (car star-rep))
                      ;; :WAS "\\(cl::\\)\\([a-z-]+\\)\\(\\*\\)" "\\1\\\\\\2"
                      "\\1\\\\\\2"
                      star-string-maybe t nil))
        (setq transd  star-string-maybe))
    transd))
;;
;;; :TEST-ME (mon-CL-escape-star "cl-symbol")
;;; :TEST-ME (mon-CL-escape-star "cl-symbol*")
;;; :TEST-ME (mon-CL-escape-star "cl::cl-symbol" t)
;;; :TEST-ME (mon-CL-escape-star "cl::cl-symbol*" t)

;;; ==============================
;;; :CREATED <Timestamp: #{2010-01-20T14:30:17-05:00Z}#{10033} - by MON>
(defun mon-CL-escape-regexp (symbol-string &optional has-colon)
  "Return list containing SYMBOL-STRING and a regexp to convert a CL symbol.
Default is to return a list with the form:\n
\(\"\\\\\(symbol\\\\\)\\\\_>\" \"cl::symbol\"\)
\(\"\\\\\(symbol\\\\*\\\\\)\\\\_>\" \"cl::symbol*\"\)\n
When optional arge HAS-COLON is non-nil return list with the form:\n
\(\"\\\\\(cl::symbol\\\\\)\\\\_>\" \"symbol\"\)
\(\"\\\\\(cl::symbol\\\\*\\\\\)\\\\_>\" \"symbol*\"\)\n
:NOTE The match-grouping of regexps in the car of the list isn't absolutely
neccessary and might slow things down a bit, however, their use allows manual
edits of the resulting regexp transformations should this be what is wanted.\n
:SEE-ALSO `mon-CL-escape-star', `mon-CL-namespace-colonic',
`mon-CL-cln-colon-swap', `*regexp-clean-cl-symbols*',
`*clean-cl-symbols-with-regexp*', `byte-compile-cl-functions',
`byte-compile-find-cl-functions', `byte-compile-cl-warn',
`byte-compile-cl-file-p'.\n▶▶▶"
  (let ((trans-to-regexp (mon-CL-escape-star symbol-string has-colon))
        (with-regexp
            (if has-colon
                '("\\(cl::\\)\\([a-z-]+\\)\\(\\\\\\*\\)?" 
                  ;;^1^^^^^^^^^2^^^^^^^^^^^^3^^^^^^^^^^   
                  . "\\\\(\\2\\3\\\\)\\\\_>")
                '("\\([a-z-]+\\)\\(\\\\\\*\\)?" 
                  ;;^1^^^^^^^^^^^^2^^^^^^^^^^
                  . "\\\\(cl::\\1\\2\\\\)\\\\_>"))))
    (setq trans-to-regexp
          (replace-regexp-in-string
           (car with-regexp) (cdr with-regexp)
           trans-to-regexp t nil))
    `(,trans-to-regexp ,symbol-string)))
;;
;;; :TEST-ME (mon-CL-escape-regexp "cl-symbol")
;;; :TEST-ME (mon-CL-escape-regexp "cl-symbol*")
;;; :TEST-ME (mon-CL-escape-regexp "cl::cl-symbol" t)
;;; :TEST-ME (mon-CL-escape-regexp "cl::cl-symbol*" t)

;;; ==============================
;;; :TODO Would be nice to also use the symbol list from Pascal Bourguignon's
;;; :FILE `cl-magic*.el's
;;; :CREATED <Timestamp: #{2010-01-15T14:37:15-05:00Z}#{10025} - by MON KEY>
(defun mon-CL-namespace-colonic (start end &optional remove-colon)
  "Prefix function symbols provided by CL packages with `cl::'.\n
Replace `symbol' with `CL::SYMBOL' in region from START to END.\n
When optional arg REMOVE-COLON is non-nil invert colon symbols to substitute
`cl::symbol' with `symbol'.\n
:SEE-ALSO `mon-CL-escape-star', `mon-CL-escape-regexp', `mon-CL-cln-colon-swap',
`*regexp-clean-cl-symbols*', `*clean-cl-symbols-with-regexp*',
`byte-compile-cl-functions', `byte-compile-find-cl-functions',
`byte-compile-cl-warn', `byte-compile-cl-file-p'.\n▶▶▶" 
  (interactive "r\nP")
  (unless (eq (caar *regexp-clean-cl-symbols*) :TO-COLON) (mon-CL-cln-colon-swap))
  (mon-replace-region-regexp-lists 
   start end (cdr (assoc (if remove-colon :FROM-COLON :TO-COLON) *regexp-clean-cl-symbols*))))

;;; ==============================
;;; :CREATED <Timestamp: #{2010-01-19T20:45:29-05:00Z}#{10033} - by MON KEY>
(defun mon-CL-cln-colon-swap (&optional forced-colonic)
  "Modifify `*regexp-clean-cl-symbols*' to hold an alist of generated regexps.
Generate regexps for the CL namespace colonic adding :TO-COLON and :FROM-COLON
keys with the string pairs of `*clean-cl-symbols-with-regexp*'.\n
Keys associate regexp lists to transform cl function symbols of cl-seq.el.
The cdr of :TO-COLON contains regexp for substituting `symbol' -> `CL::symbol'.
To invert the colon use the cdr of :FROM-COLON and get `CL::symbol' -> `symbol'.
Will not rebind a pre-existing regexp list in `*regexp-clean-cl-symbols*'
unless optional arg FORCED-COLONIC is non-nil.\n
:EXAMPLE\n\n\(mon-CL-cln-colon-swap t\)\n
\(mon-CL-cln-colon-swap\)\n
:NOTE When (re)loading this package the FORCED-COLONIC arg is t.\n
:SEE-ALSO `mon-CL-escape-star', `mon-CL-escape-regexp'
`mon-CL-namespace-colonic', `*regexp-clean-cl-symbols*',
`*clean-cl-symbols-with-regexp*', `byte-compile-cl-functions',
`byte-compile-find-cl-functions', `byte-compile-cl-warn',
`byte-compile-cl-file-p'.\n▶▶▶"
  (if  (or forced-colonic
           (not (eq (caar *regexp-clean-cl-symbols*) :TO-COLON)))
       (let ((colonic-mogrifications
              #'(lambda (&optional colonized) 
                  (let ((rgxpify
                         (mapcar (if colonized 'cadr 'car)
                                 *clean-cl-symbols-with-regexp*))
                        hold-on)
                    (dolist (rx rgxpify (setq hold-on 
                                              `(,(if colonized  :TO-COLON :FROM-COLON) 
                                                 ,@(nreverse hold-on))))
                      (push (mon-CL-escape-regexp rx colonized) hold-on))))))
         (progn
           (setq *regexp-clean-cl-symbols* nil)
            (push (funcall colonic-mogrifications) *regexp-clean-cl-symbols*)
            (push (funcall colonic-mogrifications t) *regexp-clean-cl-symbols*)))
       (message 
        (concat ":FUNCTION `mon-CL-cln-colon-swap' "
                "-- we've given `*clean-cl-symbols-with-regexp*' her colonic already"))))
                
;;
;;; :TEST-ME (mon-CL-cln-colon-swap)
;;; :TEST-ME (describe-variable '*regexp-clean-cl-symbols*)
;;; :TEST-ME (progn (mon-CL-cln-colon-swap) (mon-CL-cln-colon-swap))
;;; :TEST-ME (mon-CL-cln-colon-swap t)

;;; ==============================
;;; :NOTE Following is the output from `byte-compile-cl-functions'
;;;
;;; (tree-equal nsublis sublis nsubst-if-not nsubst-if nsubst subst-if-not
;;;  subst-if subsetp nset-exclusive-or set-exclusive-or nset-difference
;;;  set-difference nintersection intersection nunion union rassoc-if-not
;;;  rassoc-if rassoc* assoc-if-not assoc-if assoc* cl-adjoin member-if-not
;;;  member-if member* merge stable-sort sort* search mismatch count-if-not
;;;  count-if count position-if-not position-if position find-if-not find-if
;;;  find nsubstitute-if-not nsubstitute-if nsubstitute substitute-if-not
;;;  substitute-if substitute delete-duplicates remove-duplicates delete-if-not
;;;  delete-if delete* remove-if-not remove-if remove* replace fill reduce
;;;  compiler-macroexpand define-compiler-macro assert check-type typep
;;;  cl-struct-setf-expander defstruct define-modify-macro callf2 callf letf*
;;;  letf rotatef shiftf remf cl-do-pop psetf setf get-setf-method defsetf
;;;  define-setf-method declare the locally multiple-value-setq
;;;  multiple-value-bind lexical-let* lexical-let symbol-macrolet macrolet
;;;  labels flet progv psetq do-all-symbols do-symbols dotimes dolist do* do
;;;  loop return-from return block etypecase typecase ecase case load-time-value
;;;  eval-when destructuring-bind function* defmacro* defun* gentemp gensym
;;;  cl-prettyexpand cl-macroexpand-all cl-hash-table-count cl-hash-table-p
;;;  cl-make-hash-table cl-maphash cl-clrhash cl-remhash cl-puthash cl-gethash
;;;  remprop cl-remprop cl-do-remf cl-set-getf getf get* tailp list-length
;;;  nreconc revappend concatenate subseq cl-float-limits random-state-p
;;;  make-random-state random* signum rem* mod* round* truncate* ceiling* floor*
;;;  isqrt lcm gcd cl-progv-before cl-set-frame-visible-p cl-map-overlays
;;;  cl-map-intervals cl-map-keymap-recursively cl-map-keymap notevery notany
;;;  every some mapcon mapcan mapl maplist map cl-mapcar-many equalp coerce
;;;  cl-hack-byte-compiler pairlis acons cl-do-subst subst adjoin cl-mod
;;;  cl-round cl-truncate cl-ceiling cl-floor cl-member cl-maclisp-member
;;;  copy-list ldiff list* cddddr cdddar cddadr cddaar cdaddr cdadar cdaadr
;;;  cdaaar cadddr caddar cadadr cadaar caaddr caadar caaadr caaaar cdddr cddar
;;;  cdadr cdaar caddr cadar caadr caaar tenth ninth eighth seventh sixth fifth
;;;  fourth third endp rest second first svref mapcar* copy-seq evenp oddp
;;;  minusp plusp floatp-safe cl-random-time declaim proclaim cl-compiling-file
;;;  cl-macroexpand macroexpand nth-value multiple-value-call
;;;  multiple-value-apply multiple-value-list values-list values cl-block-throw
;;;  cl-block-wrapper cl-map-extents cl-set-substring cl-set-buffer-substring
;;;  cl-set-nthcdr cl-set-elt pushnew push pop decf incf cl-unload-function
;;;  cl-defsubst-expand defsubst* cl-byte-compile-compiler-macro
;;;  compiler-macroexpand define-compiler-macro assert check-type typep
;;;  cl-make-type-test deftype cl-struct-setf-expander defstruct
;;;  define-modify-macro callf2 callf letf* letf rotatef shiftf remf cl-do-pop
;;;  psetf setf cl-setf-simple-store-p cl-setf-do-store cl-setf-do-modify
;;;  get-setf-method cl-setf-make-apply defsetf define-setf-expander
;;;  define-setf-method declare cl-do-proclaim the locally multiple-value-setq
;;;  multiple-value-bind cl-defun-expander lexical-let* lexical-let
;;;  symbol-macrolet macrolet labels flet progv psetq do-all-symbols do-symbols
;;;  dotimes dolist cl-expand-do-loop do* do cl-loop-build-ands
;;;  cl-loop-handle-accum cl-loop-let cl-parse-loop-clause loop return-from
;;;  return cl-byte-compile-throw cl-byte-compile-block block etypecase typecase
;;;  ecase case load-time-value cl-compile-time-too eval-when destructuring-bind
;;;  cl-arglist-args cl-do-arglist cl-transform-lambda
;;;  cl-transform-function-property function* defmacro* defun* gentemp gensym
;;;  cl-expr-depends-p cl-expr-contains-any cl-expr-contains
;;;  cl-expr-access-order cl-const-expr-val cl-const-exprs-p cl-const-expr-p
;;;  cl-safe-expr-p cl-simple-exprs-p cl-simple-expr-p cl-pop2)
;;; ==============================

;;; ==============================
(provide 'mon-cl-compat-regexps)
;;; ==============================


;; Local Variables:
;; generated-autoload-file: "./mon-loaddefs.el"
;; End:

;;; ================================================================
;;; mon-cl-compat-regexps.el ends here
;;; EOF

;; -*- mode: EMACS-LISP; -*-
;;; this is naf-mode-english-roles.el
;;; ================================================================
;;; DESCRIPTION:
;;; naf-mode-english-roles lists English words describing naf entity roles.
;;; Terms ostly taken from ULAN. Used with `naf-mode' for font-locking.
;;; `naf-mode-english-roles' --> `naf-mode-artist-name-face'
;;;
;;; FUNCTIONS:►►►
;;;
;;; FUNCTIONS:◄◄◄
;;;
;;; CONSTANTS:
;;; `naf-mode-english-roles-secondary', `naf-mode-english-roles-primary'
;;;
;;; VARIABLES:
;;;
;;; GROUPS:
;;; `naf-mode-english-roles'
;;;
;;; MACROS:
;;;
;;; SUBST or ALIASES:
;;;
;;; DEPRECATED, RENAMED, OR MOVED:
;;;
;;; REQUIRES:
;;;
;;; TODO:
;;;
;;; NOTES:
;;; This file uses the provide/require idiom because of the defconstant forms.
;;;
;;; SNIPPETS:
;;;
;;; THIRD PARTY CODE:
;;;
;;; AUTHOR: MON KEY
;;; MAINTAINER: MON KEY
;;;
;;; PUBLIC-LINK: (URL `http://www.emacswiki.org/emacs/naf-mode-english-roles.el')
;;; FILE-PUBLISHED: <Timestamp: #{2009-11-21T20:35:49-05:00Z}#{09477} - by MON KEY>
;;;
;;; FILE-CREATED:
;;; <Timestamp: #{2009-08-09T12:19:54-04:00Z}#{09327} - by MON KEY>
;;; ================================================================
;;; This file is not part of GNU Emacs.
;;;
;;; This program is free software; you can redistribute it and/or
;;; modify it under the terms of the GNU General Public License as
;;; published by the Free Software Foundation; either version 3, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program; see the file COPYING.  If not, write to
;;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;;; Floor, Boston, MA 02110-1301, USA.
;;; ================================================================
;;; Permission is granted to copy, distribute and/or modify this
;;; document under the terms of the GNU Free Documentation License,
;;; Version 1.3 or any later version published by the Free Software
;;; Foundation; with no Invariant Sections, no Front-Cover Texts,
;;; and no Back-Cover Texts. A copy of the license is included in
;;; the section entitled "GNU Free Documentation License".
;;; A copy of the license is also available from the Free Software
;;; Foundation Web site at:
;;; (URL `http://www.gnu.org/licenses/fdl-1.3.txt').
;;; ================================================================
;;; Copyright © 2009-2011 MON KEY 
;;; ==============================

;;; CODE:


(eval-when-compile (require 'cl))

(unless (and (intern-soft "*IS-MON-OBARRAY*")
             (bound-and-true-p *IS-MON-OBARRAY*))
(setq *IS-MON-OBARRAY* (make-vector 17 nil)))

;;; ==============================
(provide 'naf-mode-english-roles)
;;; ==============================

(defgroup naf-mode-english-roles nil
  "Customization group for variables and functions of :FILE naf-mode-english-roles.el\n
:SEE-ALSO .\n►►►"
  ;; :prefix "<PREFIX>"
  :link '(url-link 
          :tag ":EMACSWIKI-FILE" "http://www.emacswiki.org/emacs/naf-mode-english-roles.el")
  :link '(emacs-library-link "naf-mode-english-roles.el")
  :group 'naf-mode)

;;; ==============================
;;; A list of english role terms: English Role Terms:
;;; ==============================
(let ((naf-english-roles-primary
      (list
       ;; primary cases
       "Actor"
       "Actress"
       "Advertising Artist"
       "Animator"
       "Architect"
       "Art Critic"
       "Art Director"
       "Artist"
       "Author"
       "Author"
       "Botanist"
       "Caricaturist"
       "Cartographer"
       "Cartoonist"
       "Choreographer"
       "Chromolithographer"
       ;;       "Children's Book Artist"
       "Clothing Designer"
       "Comedian"
       "Commercial Artist"
       "Composer"
       "Conductor"
       "Costume Designer"
       "Costumer"
       "Craftsman"
       "Critic"
       "Dancer"
       "Decorative Artist"
       "Designer Firm"
       "Designer"
       "Designer"
       "Draftsman"
       "Dressmaker"
       "Editor"
       "Engraver"
       "Entomologist"
       "Etcher"
       "Fashion Artist"
       "Fashion Designer"
       "Fashion Designers"
       "Fashion Illustrator"
       "Fashion Photographer"
       "Furniture Designer"
       "Glass Designer"
       "Glassmaker"
       "Graphic Artist"
       "Graphic Designer"
       "Humorist"
       "Illustrator"
       "Interior Decorator"
       "Interior Designer"
       "Jeweler"
       "Journalist"
       "Landscape Artist"
       "Landscape Painter"
       "Landscapist"
       "Lithographer"
       "Manufactory"
       "Marine Painter"
       "Metalworker"
       "Medalist"
       "Mezzotinter"
       "Miniaturist"
       "Muralist"      
       "Music Critic"
       "Musican"
       "Naturalist"
       "Oil Painter"
       "Ornithologist"
       "Painter" 
       "Performing Artist"
       "Photo Journalist"
       "Photoengraver"
       "Photographer"
       "Photolithographer"
       "Playwright"
       "Poet"
       "Portraitist"
       "Poster Artist"
       "Potrait Painter"
       "Printer"
       "Printmaker"
       "Satirist"
       "Scientific Illustrator"
       "Sculptor"
       "Serigrapher"
       "Set Designer"
       "Singer"
       "Still Life Painter"
       "Still Photographer"
       "Tapestry Designer"
       "Tapestry Manufactory"
       "Tempera Painter"
       "Textile Artist"
       "Textile Designer"
       "Topographer"
       "Typographer"
       "Watercolorist"
       "Zooologist"
       )))
;;
(defconst naf-mode-english-roles-primary
 (concat "\\(" (regexp-opt naf-english-roles-primary 'paren) "\\(,?\\)\\)" )
 "List of english words describing naf entity roles mostly taken from ULAN.
Catches Capitalized primary roles for naf-insertion to dbc-db.
Used with `naf-mode' when fontlocking"))
;; :type '(repeat string)
;; :group 'naf-mode-english-roles)

;;; ==============================
(let ((naf-english-roles-secondary
      (list
       ;; secondary cases
       "abstract artist"
       "actor"
       "actress"
       "advertising artist"
       "ambrotypist"
       "animal painter"
       "animal sculptor"
       "animator"
       "antiquarian"
       "antiquary"
       "apostate"
       "aquatinter"
       "armorer"
       "art critic"
       "art dealer"
       "art director"
       "art museum"
       "art union"
       "artisan"
       "artist-in-residence"
       "artists' colorman"
       "assemblage artist"
       "atelier"
       "auction house"
       "auctioneer"
       "author"
       "barometer maker"
       "basket maker"
       "batik artist"
       "billboard artist"
       "biographer"
       "blacksmith"
       "boatbuilder"
       "book dealer"
       "book dealers"
       "bookbinder"
       "bookbinders"
       "bookmaker"
       "botanist"
       "brazier"
       "bronzeworker"
       "burnisher"
       "cabinetmaker"
       "cabinetmakers"
       "calligrapher"
       "caricaturist"
       "caricaturists"
       "carpenter"
       "carpet maker"
       "cartographer"
       "cartoonist"
       "carver"
       "caster"
       "cavalier"
       "ceiling painter"
       "ceramicist"
       "ceramics manufactory"
       "ceramics studio"
       "chairmaker"
       "chaser"
       "chauffeur"
       "choreographer"
       "chromolithographer"
       "cinematographer"
       "cityscape painter"
       "clockmaker"
       "clothes designer"
       "clothing designer"
       "clothing designer"
       "clothing manufacturer"
       "coach maker"
       "coach painter"
       "coin engraver"
       "collagist"
       "collector"
       "colorer"
       "comedian"
       "commercial artist"
       "composer"
       "compositor"
       "condottiere"
       "conductor"
       "connoisseur"
       "conservator"
       "cooper"
       "coppersmith"
       "copyist"
       "costume designer"
       "costumer"
       "court artist"
       "courtier"
       "craftsman"
       "craftsmen"
       "critic"
       "curator"
       "currier"
       "daguerreotypist"
       "daguerreotypists"
       "dancer"
       "dealer"
       "dealers"
       "decorative artist"
       "delineator"
       "design firm"
       "designer"
       "designers studio"
       "die maker"
       "digital photographer"
       "dissident artist"
       "dollmaker"
       "draftsman"
       "draftsmen"
       "dressmaker"
       "dyer"
       "editor"
       "electroplater"
       "emblem maker"
       "embroiderer"
       "enameler"
       "enamelers"
       "engraver"
       "engravers"
       "entomologist"
       "etcher"
       "etchers"
       "fabric painter"
       "fan maker"
       "fashion artist"
       "fashion designer"
       "fashion designer"
       "fashion designers"
       "fashion illustrator"
       "fashion photographer"
       "fellmonger"
       "feminist"
       "fiber artist"
       "figure painter"
       "film critic"
       "film director"
       "film editor"
       "filmmaker"
       "floral designer"
       "floral painter"
       "folk artist"
       "forger"
       "fresco painter"
       "furniture designer"
       "furniture maker"
       "furniture makers"
       "furniture manufactory"
       "furrier"
       "garden designer"
       "gardener"
       "gem carver"
       "genre painter"
       "gilder"
       "gilders"
       "glass carver"
       "glass cutter"
       "glass designer"
       "glass makers studio"
       "glass painter"
       "glass painters"
       "glass stainer"
       "glassblower"
       "glassmaker"
       "glassworker"
       "glassworkers"
       "glazier"
       "goldsmith"
       "graffiti artist"
       "grainer"
       "graphic artist"
       "graphic designer"
       "gunsmith"
       "hagiographer"
       "hairdresser"
       "harpsichord maker"
       "herbalist"
       "heresiarch"
       "history painter"
       "holographer"
       "horticulturist"
       "humorist"
       "hydrographer"
       "illuminator"
       "illustrator"
       "illustrator"
       "illustrators"
       "impresario"
       "incicsor"
       "incisors"
       "industrialist"
       "inlayer"
       "inscriber"
       "installation artist"
       "instrument maker"
       "instrument makers"
       "instrumentalist"
       "intarsia artist"
       "interior decorator"
       "interior designer"
       "interior designer"
       "ironsmith"
       "itinerant artist"
       "japanner"
       "jeweler"
       "lace maker"
       "lacquer artist"
       "lacquerer"
       "lamp maker"
       "landscape architect"
       "landscape artist"
       "landscapist"
       "lapidary"
       "leather dresser"
       "leatherworker"
       "leatherworker"
       "letterer"
       "lexicographer"
       "librettist"
       "lighting designer"
       "limner"
       "literary critic"
       "literary historian"
       "lithographer"
       "lithographers"
       "luthier"
       "lyricist"
       "manufactory director"
       "manufactory"
       "marble worker"
       "marine biologist"
       "marine engineer"
       "marine painter"
       "master builder"
       "materials scientist"
       "mechanical engineer"
       "medalist"
       "metalworker"
       "metalworkers"
       "metalworking studio"
       "mezzotinter"
       "miniaturist"
       "minter"
       "minters"
       "mixed-media artist"
       "model maker"
       "modeler"
       "modelers"
       "mosaicist"
       "mosaicists"
       "motion picture studio"
       "muralist"
       "museologist"
       "museum director"
       "music box maker"
       "music critic"
       "musical instrument maker"
       "musical instrument makers"
       "musician"
       "musicologist"
       "mycologist"
       "naive artist"
       "naturalist"
       "naval architect"
       "needleworker"
       "numismatist"
       "oil painter"
       "organ maker"
       "ornamentist"
       "ornithologist"
       "orthographer"
       "painter"
       "painting studio"
       "panel maker"
       "panel painter"
       "newspaper artist"
       "paper artist"
       "papermaker"
       "pastelist"
       "patternmaker"
       "performance artist"
       "performing artist"
       "pewterer"
       "photo journalist"
       "photoengraver"
       "photographer"
       "photographers"
       "photography studio"
       "photogravurist"
       "photojournalist"
       "photolithographer"
       "photomontagist"
       "pianist"
       "pietra dura artist"
       "pietra dura artists"
       "plant painter"
       "plasterer"
       "plasterwork artist"
       "playwright"
       "porcelain maker"
       "porcelain makers"
       "porcelain painter"
       "porcelain worker"
       "portraitist"
       "poster artist"
       "poster artist"
       "poster artists"
       "potter"
       "potters"
       "pottery manufactory"
       "pottery painter"
       "pressman"
       "printer"
       "printers"
       "printing firm"
       "printmaker"
       "printmakers workshop"
       "printmakers"
       "project architect"
       "puppet maker"
       "puppeteer"
       "quiltmaker"
       "renderer"
       "restorer"
       "ribbonmaker"
       "rubricator"
       "saddler"
       "sailmaker"
       "satirist"
       "scenographer"
       "schrimshander"
       "scientific illustrator"
       "scientific instrument maker"
       "scientific laboratory"
       "scientific photographer"
       "scribe"
       "sculptor"
       "sculpture studio"
       "sealmaker"
       "self-taught artist"
       "serigrapher"
       "set designer"
       "shipbuilder"
       "shoemaker"
       "sign painter"
       "silhouette artist"
       "silversmith"
       "singer"
       "smelterman"
       "stained glass artist"
       "stair builder"
       "stenciler"
       "stereotyper"
       "still life painter"
       "still photographer"
       "stone carver"
       "stonecutter"
       "stonemason"
       "stuccoist"
       "stuccoists"
       "suffragette"
       "supervising architect"
       "swordsmith"
       "tailor"
       "tapestry designer"
       "tapestry maker"
       "tapestry manufactory"
       "taxidermist"
       "tempera painter"
       "textile artist"
       "textile artists"
       "textile designer"
       "textile studio"
       "textile worker"
       "textile workers"
       "tile maker"
       "tinsmith"
       "tinsmiths"
       "toolmaker"
       "topographer"
       "toymaker"
       "typesetter"
       "typographer"
       "typographers"
       "upholsterer"
       "upholsterer"
       "vase painter"
       "vase painters"
       "veneerer"
       "violin maker"
       "wagon maker"
       "watchmaker"
       "watercolorist"
       "weaver"
       "welder"
       "wigmaker"
       "window dresser"
       "window maker"
       "wood engraver"
       "wood-carver"
       "wood-carvers"
       "woodcutter"
       "woodworker"
       "zoologist"
       )))
;; ....now we build the constant.....
(defconst naf-mode-english-roles-secondary
 (concat (regexp-opt naf-english-roles-secondary 'paren))
 "List of english words describing naf entity roles mostly taken from ULAN.
catches non-capitalized 'secondary' roles for naf-insertion to dbc-db. 
Used with `naf-mode' when fontlocking." ))
;; :type '(repeat string)
;; :group 'naf-mode-english-roles)

;;; ==============================
;;; This file uses the provide/require idiom because of the defconstant forms.
(require 'naf-mode-english-roles)
;;; (provide 'naf-mode-english-roles)
;;; ==============================


;; Local Variables:
;; generated-autoload-file: "./mon-loaddefs.el"
;; coding: utf-8
;; End:

;;; ================================================================
;;; naf-mode-english-roles.el ends here
;;; EOF

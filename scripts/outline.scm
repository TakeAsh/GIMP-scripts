; add outline

(script-fu-register
  "script-fu-outline"                 ;func name
  "Outline"                           ;menu label
  "Add outline with foreground color" ;description
  "TakeAsh"                           ;author
  "copyright 2017, TakeAsh"           ;copyright notice
  "2017-01-12"                        ;date created
  "RGBA"                              ;image type that the script works on
  SF-IMAGE      "Image"     0         ;use active image
  SF-DRAWABLE   "Drawable"  0         ;use active layer
  SF-ADJUSTMENT "Width"     '(1 1 50 1 10 0 SF-SPINNER) ;outline width
)
(script-fu-menu-register "script-fu-outline"	"<Image>/Filters/Alpha to Logo")
(define (script-fu-outline inImage inBaseLayer inWidth)
  (let*
    (
      (theImageWidth (car (gimp-drawable-width inBaseLayer)))
      (theImageHeight (car (gimp-drawable-height inBaseLayer)))
      (theOutline (car (gimp-layer-copy inBaseLayer TRUE)))
    ) ;end of local variables

    (gimp-image-undo-group-start inImage)
    (gimp-context-push)
    (gimp-selection-none inImage)

    (script-fu-util-image-add-layers inImage theOutline)
    (gimp-selection-layer-alpha theOutline)
    (gimp-selection-grow inImage inWidth)
    (gimp-edit-fill theOutline FOREGROUND-FILL)

    (gimp-layer-set-name theOutline
      (string-append (car (gimp-layer-get-name inBaseLayer)) " Outline"))

    (gimp-selection-none inImage)
    (gimp-context-pop)
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
  )
)

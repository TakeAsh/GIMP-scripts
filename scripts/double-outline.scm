; add double-outline

(script-fu-register
  "script-fu-double-outline"      ;func name
  "Double Outline"                ;menu label
  "Add double outline with foreground/background color"
                                  ;description
  "TakeAsh"                       ;author
  "copyright 2013, TakeAsh"       ;copyright notice
  "2013-02-08"                    ;date created
  "RGBA"                          ;image type that the script works on
  SF-IMAGE      "Image"         0 ;use active image
  SF-DRAWABLE   "Drawable"      0 ;use active layer
  SF-ADJUSTMENT "Width(inner)"  '(10 1 50 1 10 1 0)
  SF-ADJUSTMENT "Width(middle)" '(6  1 50 1 10 1 0)
  SF-ADJUSTMENT "Width(outer)"  '(11 1 50 1 10 1 0)
)
(script-fu-menu-register "script-fu-double-outline" "<Image>/Filters/Alpha to Logo")
(define (script-fu-double-outline inImage inBaseLayer inWidth1 inWidth2 inWidth3)
  (let*
    (
      (theImageWidth (car (gimp-drawable-width inBaseLayer)))
      (theImageHeight (car (gimp-drawable-height inBaseLayer)))
      (theOutline0 (car (gimp-layer-copy inBaseLayer TRUE)))
      (theOutline1 0)
    ) ;end of local variables

    (gimp-image-undo-group-start inImage)
    (gimp-context-push)
    (gimp-selection-none inImage)

    (script-fu-util-image-add-layers inImage theOutline0)
    (gimp-image-lower-layer inImage inBaseLayer)
    (gimp-layer-set-lock-alpha theOutline0 TRUE)
    (gimp-edit-fill theOutline0 FOREGROUND-FILL)
    (gimp-layer-set-lock-alpha theOutline0 FALSE)

    (set! theOutline1 (car (gimp-layer-copy theOutline0 TRUE)))
    (script-fu-util-image-add-layers inImage theOutline1)
    (gimp-selection-layer-alpha theOutline1)
    (gimp-selection-grow inImage inWidth1)
    (gimp-edit-fill theOutline1 BACKGROUND-FILL)
    (set! theOutline0 (car (gimp-image-merge-down inImage theOutline0 1)))

    (set! theOutline1 (car (gimp-layer-copy theOutline0 TRUE)))
    (script-fu-util-image-add-layers inImage theOutline1)
    (gimp-selection-grow inImage inWidth2)
    (gimp-edit-fill theOutline1 FOREGROUND-FILL)
    (set! theOutline0 (car (gimp-image-merge-down inImage theOutline0 1)))

    (set! theOutline1 (car (gimp-layer-copy theOutline0 TRUE)))
    (script-fu-util-image-add-layers inImage theOutline1)
    (gimp-selection-grow inImage inWidth3)
    (gimp-edit-fill theOutline1 BACKGROUND-FILL)
    (set! theOutline0 (car (gimp-image-merge-down inImage theOutline0 1)))

    (gimp-layer-set-name theOutline0 "Double Outline")

    (gimp-selection-none inImage)
    (gimp-context-pop)
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
  )
)

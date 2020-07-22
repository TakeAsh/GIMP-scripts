; add Hue changing layers

(script-fu-register
  "script-fu-gamingize"       ;func name
  "Gamingize"                 ;menu label
  "Add Hue changing layers"   ;description
  "TakeAsh"                   ;author
  "copyright 2020, TakeAsh"   ;copyright notice
  "2020-07-23"                ;date created
  "RGB RGBA"                  ;image type that the script works on
  SF-IMAGE      "Image"     0 ;use active image
  SF-DRAWABLE   "Drawable"  0 ;use active layer
  SF-ADJUSTMENT "Division"  '(12 2 36 1 6 0 1)  ;how many division of Hue
  SF-TOGGLE     "Reverse"   FALSE ;rotate reverse
)
(script-fu-menu-register "script-fu-gamingize" "<Image>/Filters/Create")
(define (script-fu-gamingize inImage inBaseLayer inDivision inReverse)
  (let*
    (
      (theBaseName (car (gimp-layer-get-name inBaseLayer)))
      (theDelta (* (/ 360.0 inDivision) (if (= inReverse FALSE) 1 -1)))
      (theLayer)
      (theOffset)
      (i 1)
    ) ;end of local variables

    (gimp-image-undo-group-start inImage)
    (gimp-context-push)

    (while (< i inDivision)
      (set! theLayer (car (gimp-layer-copy inBaseLayer TRUE)))
      (script-fu-util-image-add-layers inImage theLayer)
      (gimp-layer-set-name theLayer
        (string-append theBaseName " #" (number->string i)))
      (set! theOffset (* theDelta i))
      (cond
        ((> theOffset  180) (set! theOffset (- theOffset 360)))
        ((< theOffset -180) (set! theOffset (+ theOffset 360))))
      (gimp-drawable-hue-saturation theLayer HUE-RANGE-ALL theOffset 0 0 0)
      (set! i (+ i 1))
    )

    (gimp-context-pop)
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
  )
)

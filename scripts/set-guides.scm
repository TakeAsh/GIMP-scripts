; set-guides
(script-fu-register
  "script-fu-set-guides"      ;func name
  "Set Guides"                ;menu label
  "Set Guides"                ;description
  "TakeAsh"                   ;author
  "copyright 2023, TakeAsh"   ;copyright notice
  "2023-07-01"                ;date created
  ""                          ;image type that the script works on
  SF-IMAGE      "Image"     0 ;use active image
)
(script-fu-menu-register "script-fu-set-guides" "<Image>/Filters/Create")
(define (script-fu-set-guides inImage)
  (let*
    (
      (guides '(
        ("V" 40) ("V" 220) ("V" 400) ("V" 580) ("V" 760)
        ("H" 25) ("H" 165) ("H" 305) ("H" 445) ("H" 585)
      ))
    ) ;end of local variables
    (while (not (null? guides))
      (let*
        (
          (guide (car guides))
          (orientation (car guide))
          (position (car (cdr guide)))
        )
        (cond
          ((string=? orientation "V") (gimp-image-add-vguide inImage position))
          ((string=? orientation "H") (gimp-image-add-hguide inImage position))
        )
      )
      (set! guides (cdr guides))
    )
  )
)

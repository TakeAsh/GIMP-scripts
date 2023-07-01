; get-guide-info
(script-fu-register
  "script-fu-get-guide-info"  ;func name
  "Get Guide Info"            ;menu label
  "Get Guide Info"            ;description
  "TakeAsh"                   ;author
  "copyright 2023, TakeAsh"   ;copyright notice
  "2023-07-01"                ;date created
  ""                          ;image type that the script works on
  SF-IMAGE      "Image"     0 ;use active image
)
(script-fu-menu-register "script-fu-get-guide-info" "<Image>/Filters/Create")
(define (script-fu-get-guide-info inImage)
  (let*
    (
      (guideId (car (gimp-image-find-next-guide inImage 0)))
      (orientation)
      (position)
      (message "")
    ) ;end of local variables
    (while (not (zero? guideId))
      (set! orientation (if (zero? (car (gimp-image-get-guide-orientation inImage guideId))) "H" "V"))
      (set! position (car (gimp-image-get-guide-position inImage guideId)))
      (set! message (string-append "(\"" orientation "\" " (number->string position) ")\n" message))
      (set! guideId (car (gimp-image-find-next-guide inImage guideId)))
    )
    (gimp-message (if (zero? (string-length message)) "No guide" message))
  )
)

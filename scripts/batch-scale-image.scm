(script-fu-register
  "batch-scale-image"         ;func name
  "Scale image"               ;menu label
  "Scale image and overwrite it"  ;description
  "TakeAsh"                   ;author
  "copyright 2021, TakeAsh"   ;copyright notice
  "2021-12-04"                ;date created
  ""                          ;image type that the script works on
  SF-FILENAME "File"  ""      ;file to scale
  SF-VALUE  "Width" "1920"    ;Width to be scaled
  SF-VALUE  "Height" "1080"   ;Height to be scaled
)
(script-fu-menu-register "batch-scale-image" "<Image>/Filters/Batch")
(define (batch-scale-image filename width height)
  (gimp-message filename)
  (let*
    (
      (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
      (drawable (car (gimp-image-get-active-layer image)))
    ) ;end of local variables
    (gimp-image-scale image width height)
    (gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
    (gimp-image-delete image)
  )
)
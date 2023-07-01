; cut-to-pieces
; cut image to pieces with specified width and height
(script-fu-register
  "script-fu-cut-to-pieces"     ;func name
  "Cut to pieces"               ;menu label
  "Cut to pieces"               ;description
  "TakeAsh"                     ;author
  "copyright 2023, TakeAsh"     ;copyright notice
  "2023-07-01"                  ;date created
  ""                            ;image type that the script works on
  SF-IMAGE    "Image"     0     ;use active image
  SF-DRAWABLE "Drawable"  0     ;use active layer
  SF-VALUE    "Width"     "180" ;width of a piece
  SF-VALUE    "Height"    "140" ;height of a piece
  SF-VALUE    "X Offset"  "40"  ;x offset
  SF-VALUE    "Y Offset"  "25"  ;y offset
  SF-TOGGLE   "Trimming"  FALSE ;trimming
)
(script-fu-menu-register "script-fu-cut-to-pieces" "<Image>/Filters/Create")
(define (script-fu-cut-to-pieces inImage inLayer pieceWidth pieceHeight xOffset yOffset inTrimming)
  (gimp-image-undo-group-start inImage)
  (gimp-context-push)
  (gimp-selection-none inImage)
  (let*
    (
      (imageWidth (car (gimp-drawable-width inLayer)))
      (imageHeight (car (gimp-drawable-height inLayer)))
      (x xOffset)
      (y yOffset)
      (index 1)
      (float 0)
      (trimmedWidth 0)
      (trimmedHeight 0)
    ) ;end of local variables
    (while (<= x imageWidth)
      (gimp-image-add-vguide inImage x)
      (set! x (+ x pieceWidth))
    )
    (while (<= y imageHeight)
      (gimp-image-add-hguide inImage y)
      (set! y (+ y pieceHeight))
    )
    (set! trimmedWidth (- (- x pieceWidth) xOffset))
    (set! trimmedHeight (- (- y pieceHeight) yOffset))
    (set! x xOffset)
    (set! y yOffset)
    (while (<= (+ y pieceHeight) imageHeight)
      (while (<= (+ x pieceWidth) imageWidth)
        (gimp-image-select-rectangle inImage CHANNEL-OP-ADD x y pieceWidth pieceHeight)
        (gimp-edit-copy inLayer)
        (set! float (car (gimp-edit-paste inLayer 0)))
        (gimp-floating-sel-to-layer float)
        (gimp-item-set-name float (number->string index))
        (set! index (+ index 1))
        (set! x (+ x pieceWidth))
      )
      (set! x xOffset)
      (set! y (+ y pieceHeight))
    )
    (if (= inTrimming TRUE) (gimp-image-resize inImage trimmedWidth trimmedHeight (- 0 xOffset) (- 0 yOffset)))
  )
  (gimp-selection-none inImage)
  (gimp-context-pop)
  (gimp-image-undo-group-end inImage)
  (gimp-displays-flush)
)

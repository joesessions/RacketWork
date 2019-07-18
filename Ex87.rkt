;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

; Text editing program. Creates an empty scene of 200 x 20, and puts text in it.
; The text will be fully represented as a string, plus an index of where the cursor is.
; "Julie Loves Potatoes" with the cursor after the first "u" would be respresented
; by editor-text = "Julie Loves Potatoes" editor-index = 2.
 (define MTSC (empty-scene 200 20))
 (define-struct editor [text index])

;wishlist:

 ;***render***
;takes an editor and display it as the text editor.;
;(Nearly same); sig: editor -> image (with text and a line)
; render should consume an editor and create an image
(define (render ed)
  (overlay/align "left" "center"
               (beside
                 (text (pre-text ed) 15 "black")
                 (rectangle 1 20 "solid" "red")
                 (text (post-text ed) 15 "black"))
               (empty-scene 200 20)))

(check-expect (render (make-editor "halitosis" 4)) 
              (overlay/align "left" "center"
               (beside
                 (text "hali" 15 "black")
                 (rectangle 1 20 "solid" "red")
                 (text "tosis" 15 "black"))
               (empty-scene 200 20)))

;***run***
;accepts text ie. "blah", and starts the main with editor-text = "blah"
;and editor-index 4

;editor ->image
; Consumes and editor and draws the text situation.
; WorldState -> WorldState
(define (main ed)
  (big-bang ed
     [on-key edit]
     [to-draw render]
     ))



;***pre-text***
;editor-> string
;returns just the letters before the cursor
(define (pre-text ed)
    (cond
    [(<= 0 (editor-index ed) (string-length (editor-text ed))) (substring (editor-text ed) 0 (editor-index ed)) ]
    [(> (editor-index ed) (string-length (editor-text ed))) (editor-text ed)]
    [(< (editor-index ed) 0) ""]))
(check-expect (pre-text (make-editor "barfly" 3)) "bar")
(check-expect (pre-text (make-editor "barfly" 6)) "barfly")
(check-expect (pre-text (make-editor "barfly" 0)) "")
(check-expect (pre-text (make-editor "barfly" 10)) "barfly")
(check-expect (pre-text (make-editor "barfly" -10)) "")

;***pre-text-lite***
;editor->string
;returns just the letters before the cursor, but without the last letter.
(define (pre-text-lite ed)
    (cond
    [(<= 1 (editor-index ed) (string-length (editor-text ed))) (substring (editor-text ed) 0 (- (editor-index ed) 1)) ]
    [(> (editor-index ed) (string-length (editor-text ed))) (editor-text ed)]
    [(<= (editor-index ed) 0) ""]))

(check-expect (pre-text-lite (make-editor "barfly" 3)) "ba")
(check-expect (pre-text-lite (make-editor "barfly" 6)) "barfl")
(check-expect (pre-text-lite (make-editor "barfly" 0)) "")
(check-expect (pre-text-lite (make-editor "barfly" 10)) "barfly")
(check-expect (pre-text-lite (make-editor "barfly" -10)) "")
 

;***post-text***
;editor-> string
;returns just the letters after the cursor
(define (post-text ed)
  (cond
    [(<= 0 (editor-index ed) (string-length (editor-text ed))) (substring (editor-text ed) (editor-index ed))]
    [(> (editor-index ed) (string-length (editor-text ed))) ""]
    [(< (editor-index ed) 0) (editor-text ed)]))
(check-expect (post-text (make-editor "dogball" 3)) "ball")
(check-expect (post-text (make-editor "dogball" 0)) "dogball")
(check-expect (post-text (make-editor "dogball" 7)) "")
(check-expect (post-text (make-editor "dogball" 10)) "")
(check-expect (post-text (make-editor "dogball" -3)) "dogball")

 

;***write-text***
; editor ke -> editor
; adds the keystroke in the position of the editor-index
(define (write-text ed ke)
      (make-editor
       (string-append (pre-text ed) ke (post-text ed))
       (+ (editor-index ed) 1))
)
(check-expect (write-text (make-editor "sampletext" 3) "k") (make-editor "samkpletext" 4))
(check-expect (write-text (make-editor "sampletext" 0) "k") (make-editor "ksampletext" 1))
(check-expect (write-text (make-editor "sampletext" 10) "k") (make-editor "sampletextk" 11))


;***backspace***
; editor -> editor
; deletes the character in front of the cursor and brings the cursor back one index

 

;***accept-input***
; ke -> bool
; determines if the input is valid.
(define (accept-input ke)
    (or (and (= (string-length ke) 1) (not (string=? ke "\t")) (not (string=? ke "\r"))) ;acceptable key to add and room to add it.
        (or (string=? ke "\b")   (string=? ke "left") (string=? ke "right")))) ; left, right or backspace.

(check-expect (accept-input "q") #true)
(check-expect (accept-input "Q") #true)
(check-expect (accept-input "\b") #true)
(check-expect (accept-input "4") #true)
(check-expect (accept-input "left") #true)
(check-expect (accept-input "right") #true)
(check-expect (accept-input "10") #false)
(check-expect (accept-input "\r") #false)
(check-expect (accept-input "\t") #false)
(check-expect (accept-input "longword") #false)

 

; ***edit***
; editor ke -> editor
; Takes an editor and ke and makes the new state of editor.
(define (edit ed ke)
  (if (accept-input ke)
      (cond
        [(string=? "\b" ke)    (make-editor
                                (string-append
                                    (pre-text-lite ed) (post-text ed)
                                )
                                (- (editor-index ed) 1)
                               )]
        [(string=? "left" ke)  (make-editor (editor-text ed) (- (editor-index ed) 1))]
        [(string=? "right" ke) (make-editor (editor-text ed) (+ (editor-index ed) 1))]
        [(and (< (image-width (text (editor-text ed) 15 "black")) 198) (= (string-length ke) 1)) (write-text ed ke)]
        [else ed] ;if input too long
      )
      ed ; if unacceptable input
  )
)

 
(check-expect (edit (make-editor "what's up" 3) "Q") (make-editor "whaQt's up" 4))
(check-expect (edit (make-editor "what's up" 3) "\t") (make-editor "what's up" 3))
(check-expect (edit (make-editor "what's up" 3) "\r") (make-editor "what's up" 3))
(check-expect (edit (make-editor "what's up" 3) "r") (make-editor "whart's up" 4))
(check-expect (edit (make-editor "what's upxxxxxxxxxxxxxxxxxxxxxxxxxxxx" 3) "r") (make-editor "what's upxxxxxxxxxxxxxxxxxxxxxxxxxxxx" 3))
(check-expect (edit (make-editor "what's up" 3) "left") (make-editor "what's up" 2))
(check-expect (edit (make-editor "what's up" 3) "right") (make-editor "what's up" 4))
(check-expect (edit (make-editor "what's up" 3) "\b") (make-editor "wht's up" 2))




; pre for editor -> editing function running
; Consumes a pre and starts the project.
(define (run pre)
  (main (make-editor "pre" 3)))

(run "start")
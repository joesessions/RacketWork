;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; sig: editor -> image (with text and a line)
; render should consume an editor and create an image
(define (render e)
  (overlay/align "left" "center"
               (beside
                 (text (editor-pre e) 15 "black")
                 (rectangle 1 20 "solid" "red")
                 (text (editor-post e) 15 "black"))
               (empty-scene 200 20)))

(check-expect (render (make-editor "hali" "tosis"))
              (overlay/align "left" "center"
               (beside
                 (text "hali" 15 "black")
                 (rectangle 1 20 "solid" "red")
                 (text "tosis" 15 "black"))
               (empty-scene 200 20)))

; string -> string
; Takes a string and returns the first character only
(define (string-first word)
  (if (> (string-length word) 0)
      (substring word 0 1)
      ""))
(check-expect (string-first "b") "b")
(check-expect (string-first "tomato") "t")
(check-expect (string-first "") "")

; string ->string
; gives everything but the first letter of a string
(define (string-rest word)
  (if (> (string-length word) 0)
      (substring word 1)
      word)) 
(check-expect (string-rest "blah") "lah")
(check-expect (string-rest "tomato") "omato")
(check-expect (string-rest "0") "")
(check-expect (string-rest "") "")
  
; string -> string
; string-last gives the last letter of a string
(define (string-last word)
  (if (> (string-length word) 0)
      (substring word (- (string-length word) 1))
      ""))

(check-expect (string-last "blah") "h")
(check-expect (string-last "tomato") "o")
(check-expect (string-last "") "")
  
; string -> string-remove-last
; gives back the string without the last character
(define (string-remove-last word)
  (if (> (string-length word) 0)
      (substring word 0 (- (string-length word) 1))
      ""
      ))
(check-expect (string-remove-last "blah") "bla")
(check-expect (string-remove-last "tomato") "tomat")
(check-expect (string-remove-last "y") "")
(check-expect (string-remove-last "") "")


; editor ke -> bool
; Accepts the current editor status and ke and returns true if anything should be done to the image.
(define (accept-input ed ke)
    (or (and (= (string-length ke) 1) (not (string=? ke "\t")) (not (string=? ke "\r")) (<= (image-width (render ed)) 200)) ;acceptable key to add and room to add it.
        (or (string=? ke "\b")   (string=? ke "left") (string=? ke "right")))) ; left, right or backspace.
(check-expect (accept-input (make-editor "slalsdkfja;ldskj fa;lsdkjf alsdk f" "aksdflaskdjfasdklf ") "t") #false)
(check-expect (accept-input (make-editor "stan" "lee") "\t" )#false)
(check-expect (accept-input (make-editor "stan" "lee") "\r" )#false)
(check-expect (accept-input (make-editor "st" "lee") "p" ) #true)
(check-expect (accept-input (make-editor "stan" "lee") "left") #true)
(check-expect (accept-input (make-editor "stan" "lee") "right") #true)

;editor ed and keyEvent ke, and produces a new editor.
;it adds keys to the end of the pre field. Backspace removes the last of pre. It ignores tab and return
(define (edit ed ke)
 (if (accept-input ed ke)
   (cond 
      ([string=? ke "\b"] (make-editor (string-remove-last (editor-pre ed)) (editor-post ed)))
      ([string=? ke "left"] (make-editor 
                (string-remove-last (editor-pre ed)) ;shorten pre
                (string-append
                (string-last (editor-pre ed)) ; last letter from pre plus...
                (editor-post ed))     ;post
                               ))
      ([string=? ke "right"] (make-editor
                (string-append (editor-pre ed)
                (string-first (editor-post ed))) ;lengthen pre
                (string-rest (editor-post ed))))                ;shorten post
      ([= (string-length ke) 1] (make-editor (string-append
                (editor-pre ed) ke)             ;pre
                (editor-post ed))))             ;post            (substring (editor-post ed) 1)))    ;shorten post                         
       ed))

(check-expect (edit (make-editor "firstletters" "last") " ") (make-editor "firstletters " "last"))
(check-expect (edit (make-editor "firstletters" "last") "q") (make-editor "firstlettersq" "last"))
(check-expect (edit (make-editor "firstletters" "last") "\b") (make-editor "firstletter" "last"))
(check-expect (edit (make-editor "firstletters" "last") "\t") (make-editor "firstletters" "last"))
(check-expect (edit (make-editor "firstletters" "last") "\r") (make-editor "firstletters" "last"))
(check-expect (edit (make-editor "firstletters" "last") "cancel") (make-editor "firstletters" "last"))
(check-expect (edit (make-editor "firstletters" "last") "clear") (make-editor "firstletters" "last"))
(check-expect (edit (make-editor "firstletters" "last") "start") (make-editor "firstletters" "last"))
(check-expect (edit (make-editor "firstletters" "last") "end") (make-editor "firstletters" "last"))
(check-expect (edit (make-editor "firstletters" "last") "home") (make-editor "firstletters" "last"))
(check-expect (edit (make-editor "firstletters" "last") "w") (make-editor "firstlettersw" "last"))
(check-expect (edit (make-editor "firstletters" "last") "e") (make-editor "firstletterse" "last"))
(check-expect (edit (make-editor "firstletters" "last") "r") (make-editor "firstlettersr" "last"))
(check-expect (edit (make-editor "firstletters" "last") "left") (make-editor "firstletter" "slast"))
(check-expect (edit (make-editor "firstletters" "last") "right") (make-editor "firstlettersl" "ast"))

;editor ->image
; Consumes and editor and draws the text situation.
; WorldState -> WorldState
(define (main ed)
  (big-bang ed
     [on-key edit]
     [to-draw render]
     ))

; pre for editor -> editing function running
; Consumes a pre and starts the project.
(define (run pre)
  (main (make-editor pre "")))

(run "start")
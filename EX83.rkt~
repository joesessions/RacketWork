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
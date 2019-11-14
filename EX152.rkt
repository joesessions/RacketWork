;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX152) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

;(overlay/offset i1 x y i2) → image?

;  i1 : image?
;  x : real?
;  y : real?
;  i2 : image?

; col
; num image => image
; takes a number and repeats an image vertically that many times.
(check-expect (col 2 (rectangle 20 20 "solid" "black"))
              (overlay/xy (rectangle 20 20 "solid" "black") 0 20 (rectangle 20 20 "solid" "black")))

(define (col n img)
  (cond
    [(= n 0) empty-image]
    [else (overlay/xy img 0 (image-height img) (col (sub1 n) img))]))



(define (row n img)
  (cond
    [(= n 0) empty-image]
    [else (overlay/xy img (image-width img) 0 (row (sub1 n) img))]))

(row 20 (col 20 (circle 3 "solid" "red")))
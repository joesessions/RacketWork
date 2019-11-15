;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX153 Russian Dolls|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

;out-layer dolls:
(define-struct layer [color doll])

;an RD (short for Russian Doll) is one of:
; - string
; - (make-layer string RD)

(check-expect (depth "red") 1)
(check-expect
  (depth
   (make-layer "yellow" (make-layer "green" "red")))
  3)

(define (depth an-rd)
  (cond
    [(string? an-rd) 1]
    [(layer? an-rd) (+ (depth (layer-doll an-rd)) 1)]))

;colors
;RD -> string (of colors)
(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (string-append (layer-color an-rd) ", " (colors (layer-doll an-rd)))]))

(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) "yellow, green, red")

;inner
;RD -> string (of one color)
(define (inner an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else  (inner (layer-doll an-rd))]))

(check-expect (inner (make-layer "yellow" (make-layer "green" "red"))) "red")

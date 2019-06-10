;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname WhatWasThis) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 600)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (rectangle 22 8 "solid" "black") (circle 10 "solid" "green")))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render/status]
     [stop-when end?]))

; to-ground computes distance to ground from bottom of UFO
; number - number

(define (to-ground ufo-height)
  (- HEIGHT ufo-height (image-height UFO)))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (cond
    [(> (to-ground y) (/ HEIGHT 3)) (+ y 3)]
    [(> (to-ground y) (/ HEIGHT 10)) (+ y 1)]
    [else (+ y .2)]))
    
 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
;(check-expect (render 11) (place-image UFO ... 11 MTSCN))
(define (render y)
  (place-image UFO 150 y MTSCN))

; WorldState -> Image
; adds a status line to the scene created by render  
 
; end? when ufo-height = 0
(define (end? y)
  (< (to-ground y) 1))

(define (render/status y)
  (cond
    [(<= 0 y CLOSE)
     (place-image (text "descending" 18 "green")
                  100 10
                  (render y))]
    [(and (< CLOSE y) (<= y HEIGHT))
     (place-image (text "closing in" 18 "orange")
                  100 10
                  (render y))]
    [(> y HEIGHT)
     (place-image (text "landed" 18 "red")
                  100 10
                  (render y))]))

(check-expect (render/status 42)
              (place-image (text "closing in" 11 "orange")
                           20 20
                           (render 42)))

(main 1)
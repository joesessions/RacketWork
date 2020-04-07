;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX156ThenCameTheShots) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))
 
; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired

; A Shot is a Number.
; interpretation represents the shot's y-coordinate
; Shots can be no greater than height

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot

; ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y} to the background image 
(define (to-image w)
  (cond
    [(empty? (rest w)) (place-image SHOT XSHOTS (first w) BACKGROUND)]
    [else (place-image SHOT XSHOTS (first w) (to-image (rest w)))]))


; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel
(check-expect (tock (cons 9 (cons 4 '()))) (cons 8 (cons 3 '())))
(check-expect (tock (cons 9 (cons 1 '()))) (cons 8 ()))
(check-expect (tock (cons 9 (cons 7 (cons 4 '())))) (cons 8 (cons 3 '())))
(define (tock w)
  (cond
    [(empty? (rest w))
         (cond
           [(> (first w) 0) (- (first w) 1)]
           [else ()']
    [else (cons (- (first w) 1) (tock (rest w)))]

; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world 
(check-expect (key-fire (cons 9 '()) " ") (cons HEIGHT (cons 9 '())))

; if the player presses the space bar
(define (key-fire w ke) 
  (cond
    [(string=? ke " ") (cons HEIGHT w)]))



(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))


(check-expect (to-image (cons 4 (cons 9 '())))
              (place-image SHOT XSHOTS 4 (place-image SHOT XSHOTS 9 BACKGROUND)))

;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname DataStructure) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)


(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.
 
; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

; Posn -> image
; draws of a red dot from a given posn
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 83 73))
              (place-image DOT 83 73 MTS))

; Posn -> Pons
; Increases x position by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p) (posn-up-x p (+ (posn-x p) 3)))

; Posn number -> Posn
; posn-up-x changes the x value of posn to n
(check-expect (posn-up-x (make-posn 10 10) 5) (make-posn 5 10))
(define (posn-up-x p n) (make-posn n (posn-y p)))

; Posn Number Number MouseEvt -> Posn
; reset-dot: for mouse clicks, (make-posn x y); otherwise p
(check-expect (reset-dot (make-posn 3 3) 5 7 "button-down")
              (make-posn 5 7))
(check-expect (reset-dot (make-posn 3 3) 8 9 "button-up")
              (make-posn 3 3))
(define (reset-dot p x y me)
  (cond
    [(string=? me "button-down") (make-posn x y)]
    [else p]))

(main (make-posn 20 30))
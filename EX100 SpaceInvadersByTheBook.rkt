;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX100 SpaceInvadersByTheBook|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; SpaceInvaders by the book.

(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define GAMESPEED 4)
(define SCNHGT 800)
(define SCNWDT 800)
(define MTSCN (empty-scene SCNWDT SCNHGT))
(define DESCENT-SPEED (* GAMESPEED 1))
(define MISSILE-SPEED (* GAMESPEED 3))
(define TICK 1)

(define-struct pson [x y])
(define-struct tank [x spd])
(define UFO (overlay (rectangle 88 8 "solid" "black") (circle 40 "solid" "green")))
(define TANK (overlay/offset (rectangle 4 15 "solid" "black") 0 15 (rectangle 40 15 "solid" "black")))
(define MISSILE (rectangle 2 20 "solid" "black"))

;***SpaceInvaderGameState
;- (make-aim UFO Tank)
;  (make-fired UFO Tank Missile)
; interpretation: represents the complete state of a space invader game.

(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) MTSCN))]
    [(fired? s)
     (tank-render
      (fired-tank s)
      (ufo-render (fired-ufo s)
                  (missile-render (fired-missile s)
                                  MTSCN)))]))



    
               
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX94 SpaceInvaders|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define SCNHGT 1000)
(define SCNWDT 800)
(define MTSCN (empty-scene SCNHGT SCNWDT))
(define DESCENT-SPEED 1)
(define MISSILE-SPEED 3)

(define-struct ufo [x y spd])
(define-struct tank [x spd])
(define-struct missile [x y])
(define-struct ws [Ufo Tank Missile Tick])

;Wishlist:
(define UFO (overlay (rectangle 88 8 "solid" "black") (circle 40 "solid" "green")))
(define TANK (overlay/offset (rectangle 4 15 "solid" "black") 0 15 (rectangle 40 15 "solid" "black")))
(define TANKBULLET (rectangle 2 20 "solid" "black"))
(define UFOBULLET (rectangle 2 20 "solid" "green"))

;***RIGHTLIMIT
;scn and image widths (number)-> number
(define RUFOLIMIT (- SCNWDT (/ (image-width UFO) 2)))
(define LUFOLIMIT (/ (image-width UFO) 2))
(define RTANKLIMIT (- SCNWDT (/ (image-width TANK) 2)))
(define LTANKLIMIT (/ (image-width TANK) 2))
;
UFO
UFOBULLET
TANKBULLET
TANK
MTSCN



;world-state

;***on-tick
;ws -> ws
;

;on-key
;ws (ke) ->ws

;render
;ufoplacer
;tankplacer



;***tank-mover
; tank -> tank
; each tick, tank-x has spd added to it.
; if tank-x outside of range, tank-x=20 or tank-x=780 and tank-spd=0.
; if distance to limit is less than the approaching speed, speed becomes distance to limit.
(define (tank-mover tank)
  (cond
    [(and (> (tank-spd tank) 0) (< (tank-x tank) (- RTANKLIMIT (tank-spd tank)))) (make-tank (+ (tank-x tank) (tank-spd tank)) (tank-spd tank))]
    [(and (< (tank-spd tank) 0) (> (tank-x tank) (- LTANKLIMIT (tank-spd tank)))) (make-tank (+ (tank-x tank) (tank-spd tank)) (tank-spd tank))]
    [(and (> (tank-spd tank) 0) (>= (tank-x tank) (- RTANKLIMIT (tank-spd tank)))) (make-tank RTANKLIMIT 0)]
    [(and (< (tank-spd tank) 0) (<= (tank-x tank) (- LTANKLIMIT (tank-spd tank)))) (make-tank LTANKLIMIT 0)]
    [else (make-tank (tank-x tank) 0)]))
(check-expect (tank-mover (make-tank 100 5)) (make-tank 105 5))
(check-expect (tank-mover (make-tank RTANKLIMIT 5)) (make-tank RTANKLIMIT 0))
(check-expect (tank-mover (make-tank LTANKLIMIT -5)) (make-tank LTANKLIMIT 0))
(check-expect (tank-mover (make-tank RTANKLIMIT 1)) (make-tank RTANKLIMIT 0))
(check-expect (tank-mover (make-tank LTANKLIMIT -1)) (make-tank LTANKLIMIT 0))
(check-expect (tank-mover (make-tank 100 -3)) (make-tank 97 -3))
(check-expect (tank-mover (make-tank (- RTANKLIMIT 3) 5)) (make-tank RTANKLIMIT 0))
(check-expect (tank-mover (make-tank (+ LTANKLIMIT 1) -3)) (make-tank LTANKLIMIT 0))
(check-expect (tank-mover (make-tank (+ LTANKLIMIT 3) -5)) (make-tank LTANKLIMIT 0))


;***new-tank-speed
; ke tank -> tank
; speed can be 1, 2, 3 or 5 in each direction.
; can't go beyond range of 20-780
; 
; with each arrow key press in one direction, the tank speeds up.
; if going left at speeds 1, 2, or 3, pressing right makes it stop.
; if going left at speed 5, pressing right drops it to 2.
; if tank-x = RTANKLIMIT and pressing right, speed =0
; if tank-x = LTANKLIMIT and pressing left, speed =0
(check-expect (new-tank-speed "left" (make-tank 100 0)) -1) 
(check-expect (new-tank-speed "left" (make-tank 100 -1)) -2)
(check-expect (new-tank-speed "left" (make-tank 100 -3)) -5)
(check-expect (new-tank-speed "left" (make-tank 100 -5)) -5)
(check-expect (new-tank-speed "left" (make-tank 100 1)) 0)
(check-expect (new-tank-speed "left" (make-tank 100 3)) 0)
(check-expect (new-tank-speed "left" (make-tank 100 5)) 2)
(check-expect (new-tank-speed "right" (make-tank 100 0)) 1)
(check-expect (new-tank-speed "right" (make-tank 100 1)) 2)
(check-expect (new-tank-speed "right" (make-tank 100 2)) 3)
(check-expect (new-tank-speed "right" (make-tank 100 3)) 5)
(check-expect (new-tank-speed "right" (make-tank 100 -1)) 0)
(check-expect (new-tank-speed "right" (make-tank 100 -3)) 0)
(check-expect (new-tank-speed "right" (make-tank 100 -5)) -2)
(check-expect (new-tank-speed "right" (make-tank RTANKLIMIT -5)) 0)
(check-expect (new-tank-speed "right" (make-tank RTANKLIMIT -1)) 0)
(check-expect (new-tank-speed "left" (make-tank RTANKLIMIT 0)) -1)
(check-expect (new-tank-speed "left" (make-tank RTANKLIMIT 1)) 0)
(check-expect (new-tank-speed "right" (make-tank LTANKLIMIT 0)) 1)
(check-expect (new-tank-speed "right" (make-tank LTANKLIMIT 1)) 2)
(check-expect (new-tank-speed "left" (make-tank LTANKLIMIT -1)) 0)
(check-expect (new-tank-speed "left" (make-tank LTANKLIMIT -5)) 0)

(define (new-tank-speed ke tank)
  (cond
    [(and (< LTANKLIMIT (tank-x tank)) (string=? ke "left")) (laccelerator (tank-spd tank))]
    [(and (< (tank-x tank) RTANKLIMIT) (string=? ke "right")) (raccelerator (tank-spd tank))]
    [else 0]))

;***laccelerator
;addresses tank speed when left button is pressed.
(define (laccelerator spd)
  (cond
  [(<= -2 spd 0) (- spd 1)]
  [(= 5 spd) 2]
  [(<= 1 spd 3) 0]
  [(<= spd -3) -5]))

;***raccelerator
;addresses tank speed when right button is pressed.
(define (raccelerator spd)
  (cond
    [(= -5 spd) -2]
    [(<= -3 spd -1) 0]
    [(<= 0 spd 2) (+ spd 1)]
    [(>= spd 3) 5]))



;***random-accelerator (rnd)
;void -> int (-2 thru 2)
;every 10 ticks, the ufo changes speed. This returns that acceleration at those moments, and 0 otherwise
(define (rnd tick)
  (cond
    [(= (modulo tick 10) 0) (- (random 5) 2)]
    [else 0]))

(check-random (rnd 10) (- (random 5) 2))
(check-random (rnd 9) 0)
    

;***ufo-accelerator
;
;spd -> spd (int)
; every 10 ticks, x spd is changed randomly.
; it starts at 0
; randomly, it generates -2, -1, 0, 1 or 2. This value is added to the spdv
; the spd max is 5, and if 6 or 7 is generated, 2 is subtracted from the current speed. (or added, if -6 or -7)
(define (ufo-accelerator spd accel)
       (cond 
         [(> (+ spd accel) 5) (- spd 2)]
         [(< (+ spd accel) -5) (+ spd 2)]
         [else (+ spd accel)]))

(check-expect (ufo-accelerator -2 0) -2)
(check-expect (ufo-accelerator -4 -2) -2)
(check-expect (ufo-accelerator 5 2) 3)
(check-expect (ufo-accelerator -5 -2) -3)
(check-expect (ufo-accelerator 1 3) 4)

;***ufo-mover
; ufo-x ufo-y ufo-spd -> ufo
; if the range exceeds 20-780, it is given a speed of +-2, headed back toward the middle
; and x is set to the 20 or 780.
; The speed is added to x at each tick.
; The y motion drops at DESCENT-SPEED (constant)
(define (ufo-mover x y spd)
  (cond
    [(>= (+ x spd) RUFOLIMIT) (make-ufo RUFOLIMIT (+ y DESCENT-SPEED) -2)]
    [(<= (+ x spd) LUFOLIMIT) (make-ufo LUFOLIMIT (+ y DESCENT-SPEED)  2)]
    [else (make-ufo (+ x spd) (+ y DESCENT-SPEED) spd)]))

(check-expect (ufo-mover 200 500 3) (make-ufo 203 (+ 500 DESCENT-SPEED) 3))
(check-expect (ufo-mover (- RUFOLIMIT 2) 500 3) (make-ufo RUFOLIMIT (+ 500 DESCENT-SPEED) -2))
(check-expect (ufo-mover (+ LUFOLIMIT 5) 500 -5) (make-ufo LUFOLIMIT (+ 500 DESCENT-SPEED) 2))

;starmaker

;bigbang
;main

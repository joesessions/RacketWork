;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname RocketLaunch) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; An LRCD (for launching rocket countdown) is one of:
; - "resting"
; - a Number between -3 and -1
; - a NonnegativeNumber
; interpretation a grounded rockect, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect
 (show "resting")
 (place-image ROCKET 50 (- HEIGHT CENTER) BACKG))
 
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET 50 (- HEIGHT CENTER) BACKG)))
(check-expect
 (show 53)
 (place-image ROCKET 50 (- 53 CENTER) BACKG))

(check-expect
 (show 0)
 (place-image ROCKET 50 (- 0 CENTER) BACKG))

(define (show x)
  (cond
  [(string? x)
   (rocket-scene HEIGHT)]
  [(<= -3 x -1)
   (place-image (text (number->string x) 20 "red")
                10 (* 3/4 WIDTH)
                (rocket-scene HEIGHT))]
  [(>= x 0)
   (rocket-scene x)]))

;rocket-scene
;takes a height and places a rocket at the right place
(check-expect (rocket-scene 0)
              (place-image ROCKET 50 (- CENTER) BACKG))
(check-expect (rocket-scene 10)
              (place-image ROCKET 50 (- 10 CENTER) BACKG))

(define (rocket-scene y)
  (place-image ROCKET 50 (- y CENTER) BACKG))

; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)  
(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))
 
; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already 
(define (fly x)
  x)


; LRCD -> LRCD
(define (main s)
  (big-bang s
    [to-draw show]
    [on-key launch]))

(main "resting")  
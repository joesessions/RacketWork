;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname TrafficLight2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

;TrafficLight -> TrafficLight
;Yields the next state; given the current state
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "red") "green")
(define (tl-next cs)
  (cond
    [(string=? cs "green") "yellow"]
    [(string=? cs "yellow") "red"]
    [(string=? cs "red") "green"]))


(define BACKGROUND (empty-scene 90 30))


;TrafficLight -> Image
;renders the current state cs as an image
(check-expect (tl-render "red")
              (place-image (circle 10 "solid" "red")
                           15 15 TL-FORM))
(check-expect (tl-render "yellow")
              (place-image (circle 10 "solid" "yellow")
                           45 15 TL-FORM))
(check-expect (tl-render "green")
              (place-image (circle 10 "solid" "green")
                           75 15 TL-FORM))

(define (tl-render cs)
  (cond
    [(string=? cs "red")
       (place-image (circle 10 "solid" "red") 15 15 TL-FORM)]
    [(string=? cs "yellow")
       (place-image (circle 10 "solid" "yellow") 45 15 TL-FORM)]
    [else (place-image (circle 10 "solid" "green") 75 15 TL-FORM)]))


(define TL-FORM
  (place-image
   (circle 10 "outline" "red")
   15 15
   (place-image
    (circle 10 "outline" "yellow")
    45 15
    (place-image
     (circle 10 "outline" "green")
      75 15 BACKGROUND))))
TL-FORM


; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(traffic-light-simulation "green")

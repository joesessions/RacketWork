;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname TrafficLight) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")


(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; Starts and runs the world state.
(define (main ws)
 (big-bang  ws
  [to-draw render]
  [on-tick tock]
  [stop-when end?]))

; set the constants that determine the cycle times.
(define RED-END 50)
(define GREEN-END 100)
(define END-CYCLE 125)

; Render makes the image. takes WS -> image
(define (render ws)
  (circle 30 "solid" (current-color ws)))

;tock bumps the ws forward
(define (tock ws)
  (add1 ws))

;stopping when
(define (end? ws)
  (> ws 400))

; Current color takes ws -> "red" "green" or "yellow"
; using modulo to cycle, 1-10 red, 11-20 green, 21-25 yellow
(check-expect (current-color (- RED-END 5)) "red")
(check-expect (current-color (- GREEN-END 5)) "green")
(check-expect (current-color (- END-CYCLE 5)) "yellow")
(define (current-color ws)
  (cond
    [(<= 0 (modulo ws END-CYCLE) RED-END) "red"]
    [(<= 11 (modulo ws END-CYCLE) GREEN-END) "green"]
    [(<= 21 (modulo ws END-CYCLE) END-CYCLE) "yellow"]))



(main 1)

      


;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX115 Checked-Equality|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;************* EX115 - checked equality

(define MESSAGE1 "traffic light expected, first input was something else")
(define MESSAGE2 "traffic light expected, second input was something else")

; Any - boolean
; is the given value an element of TrafficLight?
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                    (string=? "green" x)
                    (string=? "yellow" x))]
    [else #false]))

; any any -> boolean
; are the two values elements of TrafficLight and,
; if so, are they equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
;(check-expect (light=? "yellow" 10) (error MESSAGE2))
;(check-expect (light=? 10 "yellow") (error MESSAGE1))
;(check-expect (light=? 10 10) (error MESSAGE1))

(define (light=? val1 val2)
  (cond
    [(not (light? val1)) MESSAGE1]
    [(not (light? val2)) MESSAGE2]
    [else (string=? val1 val2)]))
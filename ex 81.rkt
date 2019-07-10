;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |ex 81|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct time [hrs min sec])
; A time is a the hours, min, and seconds since midnight
;    (make-time hr min s)
; interpretation (make-time h m s) is a time that is h hours,
; m minutes and s seconds since midnight

; time -> seconds
; Takes a time and converts it to seconds since midnight
(define (total-seconds t) (+ (* (time-hrs t) 3600) (* (time-min t) 60) (time-sec t)))

(check-expect (total-seconds (make-time 1 0 0)) 3600)
(check-expect (total-seconds (make-time 1 1 1)) 3661)
(check-expect (total-seconds (make-time 0 2 2)) 122)



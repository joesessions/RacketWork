;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.8Example) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)

(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; ( r3 -> number )
; given R3 ( an ordered triple )
(define (distance3D p) (sqrt (+ (sqr(r3-x p)) (sqr(r3-y p)) (sqr(r3-z p)))))

(check-expect (distance3D (make-r3 0 3 4)) 5)
(check-expect (distance3D (make-r3 3 4 12)) 13)


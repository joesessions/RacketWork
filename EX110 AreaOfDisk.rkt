;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX110 AreaOfDisk|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; area of disk program
; *********  checked-area-of-disk
; number -> number
; NaN -> string
(check-expect (checked-area-of-disk 10) 314)
(check-expect (checked-area-of-disk -5) "area-of-disk input must be a positive number")
(check-expect (checked-area-of-disk "ten") "area-of-disk input must be a positive number")
(check-expect (checked-area-of-disk null) "area-of-disk input must be a positive number")

(define (checked-area-of-disk r)
  (cond
    [(and (number? r) (> r 0)) (area-of-disk r)]
    [else "area-of-disk input must be a positive number"]))


; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

;******* checked-make-struct
; number, number -> vec
(check-expect (checked-make-struct 2 3) (make-vec 2 3))
(check-expect (checked-make-struct 2 -3) "The vector input must be of two positive integers")
(check-expect (checked-make-struct -2 -3) "The vector input must be of two positive integers")
(check-expect (checked-make-struct -2 -3) "The vector input must be of two positive integers")
(check-expect (checked-make-struct "brown" "cow") "The vector input must be of two positive integers")

(define (checked-make-struct x y)
  (if (and (number? x) (number? y) (> x 0) (> y 0))
      (make-vec x y) "The vector input must be of two positive integers"))


(define (missile-or-not? v)
  (cond
    [(or (false? v) (posn? v)) #true]
    [else #false]))

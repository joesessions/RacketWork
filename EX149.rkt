;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX149) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math) 
; An N is one of: 
; – 0
; – (add1 N)
; interpretation represents the counting numbers

; N String -> List-of-strings 
; creates a list of n copies of s
 
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
 
(define (copier n s)
  (cond
    [(<= n 0) '()]
    [else (cons s (copier (sub1 n) s))]))


(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))

;(copier.v2 0.1 "x")

; N -> Number
; computes (+ n pi) without using +
 
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
 
(define (add-to-pi n)
  (cond
    [(= n 0) pi]
    [else (add1 (add-to-pi (sub1 n)))]))

(check-expect (add-nums 5 6) 11)

(define (add-nums x y)
  (cond
    [(= x 0) y]
    [else (add1 (add-nums (sub1 x) y))]))

; it uses check within because who knows how this deals with pi, and tiny variances in + and Add1
(check-expect (multiply 6 8) 48)

; n n -> n
; takes two numbers and multiplies them

(define (multiply x y)
  (cond
    [(or (= x 0) (= y 0)) 0]
    [(= x 1) y]
    [else (add-nums y (multiply (sub1 x) y))]))
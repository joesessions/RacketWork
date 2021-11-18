;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |EX245 Functions as inputs|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(require 2htdp/image)
;(require 2htdp/universe)
(require racket/math)
;(require 2htdp/web-io)

;(define (f x) x)
;(cons f '())
;(f f)
;(cons f (cons 10 (cons (f 10) '())))

;Exercise 244. Argue why the following sentences are now legal:
;(define (f x) (x 10))
;This is legal because x can be a primative function, and whichever function you give it will respond with 10. + gives 10, - gives -10, / gives .1
;(define (f x) (x f))
;This is legal because f can accept a predicate like string?, and x will reference back to f, which is not a string, and return false. 
;(define (f x y) (x 'a y 'b))
;This is legal because it can accept "list" as x and anything as y, and you'll get a list with y in the middle position.
;Explain your reasoning.

;Exercise 245. Develop the function=at-1.2-3-and-5.775? function. Given two functions from numbers to numbers,
;the function determines whether the two produce the same results for 1.2, 3, and -5.775.

(check-expect (plus2times2 10) 24)
(check-expect (times2plus4 10) 24)
(define (plus2times2 x) (* (+ 2 x) 2))
(define (times2plus4 x) (+ (* 2 x) 4))
(define (plus1 x) (+ x 1))

;two functions -> bool
(check-expect (function=at-1.2-3-and-5.775 plus2times2 times2plus4) #true)
(check-expect (function=at-1.2-3-and-5.775 plus2times2 plus1) #false)

(define (function=at-1.2-3-and-5.775 X Y)
  (and (and (= (X 1.2) (Y 1.2))
            (= (X 3)   (Y 3)))
            (= (X -5.775) (Y -5.775))))
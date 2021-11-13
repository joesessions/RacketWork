;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname EX236) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
(require 2htdp/web-io)

(check-expect (contains? `("dog" "cat" "zebra") "goat") #false)
(check-expect (contains? `("dog" "cat" "zebra") "cat") #true)
(define (contains? los s)
  (cond
    [(empty? los) #false]
    [(string=? (first los) s) #true]
    [else (contains? (rest los) s)]))

(define (contains-atom? los)
  (contains? los "atom"))
(define (contains-basic? los)
  (contains? los "basic"))
(define (contains-zoo? los)
  (contains? los "zoo"))

(check-expect (contains-atom? `("dog" "cat" "zebra")) #false)
(check-expect (contains-basic? `("dog" "cat" "zebra")) #false)
(check-expect (contains-zoo? `("dog" "cat" "zebra")) #false)
(check-expect (contains-atom? `("dog" "cat" "zebra" "atom")) #true)
(check-expect (contains-zoo? `("dog" "cat" "zebra" "zoo")) #true)


; Lon -> Lon
; adds 1 to each item on l
(check-expect (plus1 `(2 3 4)) `(3 4 5))
(check-expect (plus1 `(3)) `(4))
;(define (add1* l)
 ; (cond
  ;  [(empty? l) '()]
   ; [else
    ; (cons
     ;  (add1 (first l))
      ; (add1* (rest l)))]))
     
; Lon -> Lon
; adds 5 to each item on l
(check-expect (plus5 `(1 2 3)) `(6 7 8))
;(define (plus5 l)
 ; (cond
  ;  [(empty? l) '()]
   ; [else
    ; (cons
     ;  (+ (first l) 5)
      ; (plus5 (rest l)))]))

(define (plus-to-list l a)
  (cond
    [(empty? l) '()]
    [else
     (cons
      (+ (first l) a)
      (plus-to-list (rest l) a))]))

(define (plus5 l)
  (plus-to-list l 5))

(define (plus1 l)
  (plus-to-list l 1))

(check-expect (minus2 `(1 5 10)) `(-4 0 5))

(define (minus2 l)
  (plus-to-list l -5))



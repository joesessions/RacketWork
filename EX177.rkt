;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX177) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

 ;Lo1s -> Lo1s 
 ;produces a reverse version of the given list 
 
(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))
 
(check-expect (add-at-end '() "s") (cons "s" '()))

(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))


; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
 
(check-expect
  (add-at-end (cons "d" (cons "c" (cons "b" '()))) "a")
  (cons "d" (cons "c" (cons "b" (cons "a" '())))))

(check-expect
  (add-at-end '() "a")
  (cons "a" '()))

(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else (cons (first l) (add-at-end (rest l) s))]))



s










;(define (rev l)
;  (cond
;    [(empty? l) '()]
;    [else (add-at-end (rev (rest l)) (first l))]))



;(define (add-at-end l s)
;  (cond
;    [(empty? l) (cons s '())]
;    [else
;     (cons (first l) (add-at-end (rest l) s))]))





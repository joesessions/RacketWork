;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname LastThing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-Numbers -> List-of-Numbers
; produces a sorted version of alon


(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5))
              (list 20 12 -5))


; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers alon
(check-expect (insert 5 '()) (list 5))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5))
              (list 20 12 -5))

;(define (sort> alon)
;  (cond
;    [(empty? alon) '()]
;    [else
;     (insert (first alon) (sort> (rest alon)))]))


;(define (insert n alon)
;  (cond
;    [(empty? alon) (cons n '())]
;    [(>= n (first alon)) (cons n alon)]
;    [else (cons (first alon) (insert n (rest alon)))]))


(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else
     (insert (first alon) (sort> (rest alon)))]))

(define (insert n alon)
  (cond
    [(empty? alon) (cons n '())]
    [(> n (first alon)) (cons n alon)]
    [else (sort> (cons (first alon) (cons n (rest alon))))]))
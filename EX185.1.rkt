;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX185.1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-numbers -> List-of-numbers 
; rearranges alon in descending order
(check-satisfied (sort> '()) sorted>?)
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)
(check-satisfied (sort> (list 12 20 -5)) sorted>?)

(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5))
              (list 20 12 -5))
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else
     (insert (first alon) (sort> (rest alon)))]))

; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers alon
(check-expect (insert 5 '()) (list 5))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 7 (list 8 6)) (list 8 7 6))
(check-expect (insert 7 (list 9 8)) (list 9 8 7))
(check-expect (insert 7 (list 6 5)) (list 7 6 5))


(define (insert n alon)
  (cond
    [(empty? alon) (cons n '())]
    [(> n (first alon)) (cons n alon)]
    [else (cons (first alon) (insert n (rest alon)))]))

    
; sorted>?
; takes a list of nmbers and gives true if sorted desc.
(check-expect (sorted>? (list 5 3 1)) #true)
(check-expect (sorted>? (list 1 3 5)) #false)
(check-expect (sorted>? '()) #true)

(define (sorted>? alon)
  (cond
    [(empty? alon) #true]
    [(empty? (rest alon)) true]
    [(> (first alon) (first (rest alon)))
        (sorted>? (rest alon))]
    [else #false]))



; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort>/bad l)
  (list 9 8 7 6 5 4 3 2 1 0))

(check-expect (sort>/bad (list 1 2 3)) (list 3 2 1))
(check-satisfied (sort>/bad (list 1 2 3)) sorted>?)
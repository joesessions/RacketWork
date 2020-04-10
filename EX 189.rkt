;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |EX 189|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; searchSorted
; n alon -> bool
(check-expect (searchSorted 4 (list 10 7 2)) false)
(check-expect (searchSorted 10 (list 10 7 2)) true)
(check-expect (searchSorted 10 (list 100 70 10)) true)

(define (searchSorted n alon)
  (cond
    [(empty? alon) false]
    [(> n (first alon)) false]
    [(= n (first alon)) true]
    [else (searchSorted n (rest alon))]))

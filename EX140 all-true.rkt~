;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX140 all-true?|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;EX140
;

;***** all-true?
; list of bool -> bool
; if all are true, return true
(check-expect (all-true? (cons #true (cons #true (cons #true '())))) #true)
(check-expect (all-true? (cons #true (cons #true (cons #false '())))) #false)
(check-expect (all-true? (cons #true '())) #true)
(check-expect (all-true? (cons #false '())) #false)

(define (all-true? lob)
  (cond
    [(empty? lob) #true]
    [(not (first lob)) #false]
    [(all-true? (rest lob)) #true]
    [else #false]))
;***** one-true?
; list of bool -> bool
; if at least one is true, return true
(check-expect (one-true? (cons #false (cons #false (cons #false '())))) #false)
(check-expect (one-true? (cons #true (cons #true (cons #false '())))) #true)
(check-expect (one-true? (cons #true '())) #true)
(check-expect (one-true? (cons #false '())) #false)

(define (one-true? lob)
  (cond
    [(empty? lob) #false]
    [(first lob) #true]
    [(one-true? (rest lob)) #true]
    [else #false]))
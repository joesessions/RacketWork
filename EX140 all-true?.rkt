;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX140 all-true?|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;EX140
;
; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 

; An NEList-of-booleans is one of:
; - (cons boolean '())
; - (cons NEList-of-booleans boolean)
; interpretation: non-empty list of booleans



;***** all-true?
; list of bool -> bool
; if all are true, return true
(check-expect (all-true? (cons #true (cons #true (cons #true '())))) #true)
(check-expect (all-true? (cons #true (cons #true (cons #false '())))) #false)
(check-expect (all-true? (cons #true '())) #true)
(check-expect (all-true? (cons #false '())) #false)

(define (all-true? lob)
  (cond
    [(and (first lob) (empty? (rest lob))) #true]
    [(not (first lob)) #false]
    [else (all-true? (rest lob))]))
;***** one-true?
; list of bool -> bool
; if at least one is true, return true
(check-expect (one-true? (cons #false (cons #false (cons #false '())))) #false)
(check-expect (one-true? (cons #true (cons #true (cons #false '())))) #true)
(check-expect (one-true? (cons #true '())) #true)
(check-expect (one-true? (cons #false '())) #false)

(define (one-true? lob)
  (cond
    [(first lob) #true]
    [(and (not (first lob)) (empty? (rest lob))) #false]
    [else (one-true? (rest lob))]))


;EX148: It's better to work with functions that deal with non-empty lists. The logic is more intuitive and clean.

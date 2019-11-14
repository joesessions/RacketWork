;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX143 List of temps|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;EX143
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)


(check-expect
  (average2 (cons 1 (cons 2 (cons 3 '())))) 2)

; List-of-temperatures -> Number
; computes the average temperature 
(define (average alot)
  (cond
    [(empty? alot) "Cannot average zero temperatures."]
    [else (/ (sum alot) (how-many alot))]))
 
; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [(cons? alot)
      (+ (first alot) (sum (rest alot)))]))
 
; List-of-temperatures -> Number 
; counts the temperatures on the given list 
(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [(cons? alot)
     (+ (how-many (rest alot)) 1)]))


; List-of-temperatures -> Number
; computes the average temperature 
(define (average2 NElot)
  (cond
    [(empty? (rest NElot)) (first NElot)]
    [else (/ (sum NElot) (how-many NElot))]))
 
; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum2 NElot)
  (cond
    [(empty? (rest NElot)) (first NElot)]
    [else (+ (first NElot) (sum (rest NElot)))]))
 
; List-of-temperatures -> Number 
; counts the temperatures on the given list 
(define (how-many2 NElot)
  (cond
    [(empty? (rest NElot)) (first NElot)]
    [else (+ (how-many (rest NElot)) 1)]))


(check-expect
  (sorted>? (cons 1 (cons 2 (cons 3 '())))) #false)

(check-expect
  (sorted>? (cons 3 (cons 2 (cons 1 '())))) #true)

; List-of-temperatures -> bool
; true if a descending number list

(define (sorted>? alot)
  (cond
    [(empty? (rest alot)) #true]
    [else
     (cond
       [(<= (first alot) (first (rest alot))) #false]
       [else (sorted>? (rest alot))])]))



;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))



; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

;***** define pos?
;Tells if all items in list are positive integers
; lon -> bool
(define (pos? lon)
   (cond
     [(empty? lon) #true]
     [(<= (first lon) 0) #false]
     [else (pos?(rest lon))])) 
 
(check-expect (pos? (cons 1 '())) #true)
(check-expect (pos? (cons 1 (cons 2 '()))) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? '()) #false)



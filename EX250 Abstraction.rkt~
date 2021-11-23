;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |EX250 Abstraction|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
(require 2htdp/web-io)


; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(check-expect (tab-sin 3) (list #i0.1411200080598672 #i0.9092974268256817 #i0.8414709848078965 0))
(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else
     (cons
      (sin n)
      (tab-sin (sub1 n)))]))
  
; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(check-expect (tab-sqrt 4) (list 2 #i1.7320508075688772 #i1.4142135623730951 1 0))
(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
     (cons
      (sqrt n)
      (tab-sqrt (sub1 n)))]))

;tab-down-to-zero
;Integer -> List of numbers
(check-expect (tab-down-to-zero add1 3) '(4 3 2 1))
(define (tab-down-to-zero func i)
  (cond
    [(<= i 0) (list (func i))]
    [else
       (cons (func i)
             (tab-down-to-zero func (sub1 i)))]))

(check-expect (tab-down-to-zero sqr 3) '(9 4 1 0))


;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname SalesTax) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

; A Price falls into one of three intervals;
; 0 - 1000
; 1000 - 10000
; 10000 and above
; Interpretation; the price of an item without tax.

(define BOTTOM-THRES 1000)
(define TOP-THRES 10000)

; Price -> Number
; computes the amount of tax charged for p
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p BOTTOM-THRES)) 0]
    [(and (<= BOTTOM-THRES p) (< p TOP-THRES)) (* .05 p)]
    [(>= p TOP-THRES) (* .08 p)]))

(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 534) 0)
(check-expect (sales-tax 1000) (* .05 1000))
(check-expect (sales-tax 1400) (* .05 1400))
(check-expect (sales-tax 10000) (* .08 10000))
(check-expect (sales-tax 14501) (* .08 14501))

(sales-tax 234234)
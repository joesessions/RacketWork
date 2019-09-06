;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX103 ZooDataDefinition|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ***zoo-animal
; represents an animal by a few data points. name space (liters) length (m) girth (cm) number-of-legs weight (kg)
; interpretation: a "spider" 1 0 0 7 0 is a spider with 7 legs and which needs 1L to transport. Fields of 0 are unimportant

;(define-struct zoo-animal [name space length girth number-of-legs weight])

;(define (function za)
 ; ...(zoo-animal-name za)...(zoo-animal-space za)...(zoo-animal-length za)...(zoo-animal-girth za)...(zoo-animal-number-of-legs za)...(zoo-animal-weight za)...)

;***volume
;l w h => volume (ints)
;Consumes 3 linear dimensions in cm and returns a volume in L
;(define (volume l w h) (/ (* l w h) 1000))

;(define (fits? za l w h)
  ;(<= (zoo-animal-space za) (volume l w h)))
    
;(define SNAKE (make-zoo-animal "snake" 500 3 10 0 0))

 ; (fits? SNAKE 10 10 10)

; ***zoo-animal-itemized
; represents different kinds of animals
; a zoo-animal-itemized is one of:
; - a spider (legs space)
(define-struct spider [legs space])
; - an elephant (space)
(define-struct elephant [space])
; - a boa (length girth)
(define-struct boa [length girth])
; - an armadillo (scales space)
(define-struct armadillo [scales space])


(define (fits? za cage-volume)
  (cond
   [(spider? za) (<= (spider-space za) cage-volume)]
   [(elephant? za) (<= (elephant-space za) cage-volume)]
   [(boa? za) (<= (* (boa-length za) (sqr (boa-girth za))) cage-volume)]
   [(armadillo? za) (<= (armadillo-space za) cage-volume)]))

(fits? (make-spider 7 1) 2)
(fits? (make-elephant 90000) 100000)
(fits? (make-elephant 90000) 10000)
(fits? (make-boa 20 10) 1999)
(fits? (make-boa 20 10) 2999)

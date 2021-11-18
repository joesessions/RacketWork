;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |EX240 |) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
(require 2htdp/web-io)

(define-struct point [hori veri])

(define firstpoint (make-point 10 10))

(point-veri firstpoint)

; A [List X Y] is a list: 
;   (cons X (cons Y '()))
(cons 23 (cons 4 '()))

; A [List num num] is a list of two numbers:
;  (cons number (cons number '()))

; A [List number 1String] is a list of a number and a 1string
; (cons Number (cons 1String '()))
(cons 45 (cons 't' '()))

; A [List bool image]
; (cons Boolean (Image))
;(cons #true ([imagefile.jpg]))


;EX240

; An LStr is one of: 
; – String
; – (make-layer LStr)
(define-struct layer [stuff])
(define LStr1 "first")
(define LStr2 (make-layer "second"))
(define LStr3 (make-layer (make-layer "third")))
(layer-stuff (layer-stuff LStr3))

;An [LThing typ] is a structure:
; - typ
; - (make-layer LThing)

;An LStr is [LThing string]

;An LNum is a [LThing Number]




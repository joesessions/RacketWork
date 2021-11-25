;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname EX253) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
(require 2htdp/web-io)

;Exercise 253. Each of these signatures describes a class of functions:
; [Number -> Boolean]
;IsEven?
; [Boolean String -> Boolean]
;Is#TrueAndTrue?
; [Number Number Number -> Number]
;Add3Integers
; [Number -> [List-of Number]]
;ListNumbersDownToZero
; [[List-of Number] -> Boolean]
;AllPositiveIntegers?
;Describe these collections with at least one example from ISL.

;Exercise 254. Formulate signatures for the following functions:
;sort-n, which consumes a list of numbers and a function that consumes two numbers (from the list) and produces a Boolean;
;sort-n produces a sorted list of numbers.
;[List-of numbers] [number number -> Boolean] -> [List-of numbers]
;sort-s, which consumes a list of strings and a function that consumes two strings (from the list) and produces a Boolean;
;sort-s produces a sorted list of strings.
;[List-of strings] [string string -> Boolean] -> [List-of strings]


;Then abstract over the two signatures, following the above steps.
;Also show that the generalized signature can be instantiated to describe the signature of a sort function for lists of IRs. 
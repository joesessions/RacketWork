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

;[List-of X] [X X -> Boolean] -> [List-of X]
;Also show that the generalized signature can be instantiated to describe the signature of a sort function for lists of IRs.
;[List-of IR] [IR IR -> Boolean] -> [List-of IR]


;Exercise 255. Formulate signatures for the following functions:
;map-n, which consumes a list of numbers and a function from numbers to numbers to produce a list of numbers.
;[List-of numbers] [numbers->numbers] -> [List-of numbers]

;map-s, which consumes a list of strings and a function from strings to strings and produces a list of strings.
;[List-of strings] [strings->strings] -> [List-of strings]

;Then abstract over the two signatures, following the above steps. Also show that the generalized signature
;can be instantiated to describe the signature of the map1 function above.
;[List-of X] [X -> X] -> [List-of X]

;Exercise 256. Explain the following abstract function:
; [X] [X -> Number] [NEList-of X] -> X 
; finds the (first) item in lx that maximizes f
; if (argmax f (list x-1 ... x-n)) == x-i, 
; then (>= (f x-i) (f x-1)), (>= (f x-i) (f x-2)), ...
;(define (argmax f lx) ...)
;Use it on concrete examples in ISL. Can you articulate an analogous purpose statement for argmin?

(check-expect (argmax2 add1 '(-5 -1 0 2 3)) 3)
(check-expect (argmax2 sqr '(-5 -1 0 2 3)) -5)
(define (argmax2 func lon)
  (cond
    [(empty? (rest lon)) (first lon)]
    [(> (func (first lon)) (func (second lon)))
     (argmax func (cons (first lon) (rest (rest lon))))]
    [else (argmax func (rest lon))]))


(define-struct address [first-name last-name street])
; An Addr is a structure: 
;   (make-address String String String)
; interpretation associates an address with a person's name
 
; [List-of Addr] -> String 
; creates a string from first names, 
; sorted in alphabetical order,
; separated and surrounded by blank spaces
(define (listing l)
  (foldr string-append-with-space " "
         (sort (map address-first-name l) string<?)))
 
; String String -> String 
; appends two strings, prefixes with " " 
(define (string-append-with-space s t)
  (string-append " " s t))
 
(define ex0
  (list (make-address "Robert"   "Findler" "South")
        (make-address "Matthew"  "Flatt"   "Canyon")
        (make-address "Shriram"  "Krishna" "Yellow")))
 
(check-expect (listing ex0) " Matthew Robert Shriram ")

;EX257  Design build-l*st, which works just like build-list. Hint Recall the add-at-end function from exercise 193.
;number [number->number] -> lon
;Applies f to numbers to from 0 to j-1
(check-expect (build-l*st 3 +) '(1 2 3))
(check-expect (build-l*st 4 sqr) '(0 1 4 9))
(define (check-expect
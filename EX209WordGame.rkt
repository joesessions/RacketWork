;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname EX209WordGame) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

;(define LOCATION "C:/Users/Joe/Documents/NotePad++/BigDictionary.txt")  ; For windows machine
(define LOCATION "/usr/share/dict/words")
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

;A List-of-Words is one of:
; - '() or
; - (cons Word low)
(define w1 (list "d" "e"))
(define w2 (list "e" "d"))
(define low1 (list w1 w2))
(define w3 (list "f" "g"))
(define w4 (list "g" "f"))
(define low2 (list w3 w4))


; List-of-strings -> Boolean
;(define (all-words-from-rat? w)
;  (and
;    (member? "rat" w) (member? "art" w) (member? "tar" w)))
 
; String -> List-of-strings
; finds all words that the letters of some given word spell
 
;(check-member-of (alternative-words "cat")
;                 (list "act" "cat")
;                 (list "cat" "act"))
 
;(check-satisfied (alternative-words "rat")
 ;                all-words-from-rat?)
 
;(define (alternative-words s)
;(in-dictionary
 ;   (words->strings (arrangements (string->word s)))))

;***insert-everywhere/in-all-words
;1string low -> low
(check-expect (insert-everywhere/in-all-words "d"
  (cons (list "e" "r")
    (cons (list "r" "e")
      '()))) (list (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")
                   (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
(check-expect (insert-everywhere/in-all-words "d" '()) "d")
(define (insert-everywhere/in-all-words 1s low)
  (cond
    [(empty? low) 1s]
    [else (insert-everywhere/in-one-word 1s (insert-everywhere/in-all-words (first low) (rest low)))]))

;***insert-everywhere/in-one-word
;1string word (lo1strings) > low
(check-expect (insert-everywhere/in-one-word "d" (list "e" "r"))
              (list (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")))
(check-expect (insert-everywhere/in-one-word "d" (list "e")) (list (list "d" "e") (list "e" "d")))
(check-expect (insert-everywhere/in-one-word "d" (insert-everywhere/in-one-word "e" (list "r")))
                                             (list (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")
                                             (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
(check-expect (insert-everywhere/in-one-word "d" '()) (list "d"))
(define (insert-everywhere/in-one-word s w1)
  (cond
    [(empty? w1) (list s)]
    [else (letter-shuffler '() s w1)]))

;***letter-shuffler
;word 1String word > low
;iterates through the letters, to insert the 1string in each possible place. Works with above
(define (letter-shuffler w1 s w2)
  (cond
    [(empty? w2) (list (insert-between-first-and-last w1 s '()))]
    [else (cons (insert-between-first-and-last w1 s w2)
             (letter-shuffler (append w1 (list (first w2)))
                              s
                              (rest w2)))]))


;***insert-between-first-and-last
;word 1s word
(check-expect (insert-between-first-and-last '() "s" '()) (list "s"))
(check-expect (insert-between-first-and-last (list "d") "s" '()) (list "d" "s"))
(check-expect (insert-between-first-and-last '() "s" (list "e")) (list "s" "e"))
(check-expect (insert-between-first-and-last (list "d") "s" (list "e")) (list "d" "s" "e"))
(define (insert-between-first-and-last w1 s w2)
  (cond
    [(and (empty? w1) (empty? w2)) (list s)]
    [(empty? w2) (append w1 (list s))]
    [(empty? w1) (append (list s) w2)]
    [else (append w1 (list s) w2)]))




;****in-dictionary
;los dictionary > los
;consumes a list of string and returns on the ones in the dictionary
(check-expect (in-dictionary (list "dog" "cat" "wef" "onq" "me")) (list "dog" "cat" "me"))
(check-expect (in-dictionary '()) '())
(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [(contains? (first los) AS-LIST) (cons (first los) (in-dictionary (rest los)))]
    [else (in-dictionary (rest los))]))

; contains?
; s alos > bool
;(check-expect (contains? "a" (list "a")) true)
;(check-expect (contains? "a" (list "a" "b")) true)
;(check-expect (contains? "a" (list "c" "b")) false)
;(check-expect (contains? "a" '()) false)
;(check-expect (contains? "a" (list "a" "a")) true)
(define (contains? s alos)
  (cond
   [(empty? alos) false]
   [(string=? s (first alos)) true]
   [else (contains? s (rest alos))]))

;words->strings
;low (lolo1Strings) > los
(check-expect (words->strings (list (list "d" "o" "g") (list "c" "a" "t"))) (list "dog" "cat"))
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))

; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary 
;(define (in-dictionary los) '())(index "in-dictionary")

;string->word
;converts s to the chose word representation
(check-expect (string->word "dog") (list "d" "o" "g"))
(check-expect (string->word "") '())
(define (string->word s)
  (explode s))

;word->string
(check-expect (word->string (list "d" "o" "g")) "dog")
(define (word->string w)
  (implode w))


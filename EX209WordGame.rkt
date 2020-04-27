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




;***arrangements
;lo1s -> lolo1s
;given any list of characters greater than 2, it will return all permutations
(define (arrangements lo1s)
  (cond
    [(= 1 (length lo1s)) lo1s]
    [(= 2 (length lo1s)) (list lo1s (list (second lo1s) (first lo1s)))]
    [(= 3 (length lo1s)) (arrangements-of-three lo1s)]
    [else (input-all-but-last-three (first lo1s) (second lo1s) (third lo1s) (rest (rest (rest lo1s))))]))
   
(define (input-all-but-last-three a b c lo1s)
  (cond
    [(empty? lo1s) (arrangements-of-three (list a b c))]
    [else (insert-everywhere/in-all-words (first lo1s) (input-all-but-last-three a b c (rest lo1s)))])) 

;***arrangements-of-three
;given a list of three letters, it will return all permutations
;lo1s -> lolo1s
(check-expect (arrangements-of-three (list "d" "e" "r"))
              (list (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")
                   (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
(define (arrangements-of-three lot)
             (list (list (first lot) (second lot) (third lot)) (list (second lot) (first lot) (third lot)) (list (second lot) (third lot) (first lot))
                   (list (first lot) (third lot) (second lot)) (list (third lot) (first lot) (second lot)) (list (third lot) (second lot) (first lot))))
              
;***insert-everywhere/in-all-words
;1string low -> low
(check-expect (insert-everywhere/in-all-words "d"
  (cons (list "e" "r")
    (cons (list "r" "e")
      '()))) (list (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")
                   (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
(check-expect (insert-everywhere/in-all-words "d" '()) '())
(define (insert-everywhere/in-all-words 1s low)
  (cond
    [(empty? low) '()]
    [else (append (insert-everywhere/in-one-word 1s (first low)) (insert-everywhere/in-all-words 1s (rest low)))]))

;***insert-everywhere/in-one-word
;1string word (lo1strings) > low
(check-expect (insert-everywhere/in-one-word "d" (list "e" "r"))
              (list (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")))
(check-expect (insert-everywhere/in-one-word "d" (list "e")) (list (list "d" "e") (list "e" "d")))
;(check-expect (insert-everywhere/in-one-word "d" (insert-everywhere/in-one-word "e" (list "r")))
 ;                                            (list (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")
  ;                                           (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
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

; create-set
; alos > alos
(check-expect (create-set (list "a" "a" "b")) (list "a" "b"))
(check-expect (create-set (list "a" "b" "b")) (list "a" "b"))
(define (create-set alos)
  (cond
    [(empty? alos) '()]
    [(contains? (first alos) (rest alos)) (create-set (rest alos))]
    [else (cons (first alos) (create-set (rest alos)))]))

;***create-set-1s-lists
;removes duplicate lists from a list of list of 1strings
;(define (create-set-1s-lists lolo1s)
 ; (cond
  ;  [(empty? lolo1s) '()]
   ; [else (

(define s "celeste")

;(words->strings (arrangements (string->word s)))

(in-dictionary
  (words->strings
    (arrangements (string->word s))))


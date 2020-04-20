;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname EX195) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

(define LOCATION "C:/Users/Joe/Documents/NotePad++/BigDictionary.txt")  ; For windows machine

; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

(define SmallDict (list "alpha" "aggro" "anvil" "atom" "beta" "cornholio"))

(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

;*** starts-with
; letter dictionary -> number
;(check-expect (starts-with "a" SmallDict) 4)
;(check-expect (starts-with "b" SmallDict) 1)

(define (starts-with let dict)
  (cond
    [(empty? dict) 0]
    [(string=? let (first (explode (first dict)))) (+ 1 (starts-with let (rest dict)))]
    [else (starts-with let (rest dict))]))

; a letter-count is a
; letter  + number
; it shows how many of that letter are in the dictionary in question
(define-struct letter-count (let num))

; count-by-letter
; dictionary -> list of letter-counts
;(check-expect (count-by-letter SmallDict)
;              (list (make-letter-count "a" 4)
;                    (make-letter-count "b" 1)
;                    (make-letter-count "c" 1)))



(define (count-by-letter dict)
  (cond
    [(empty? dict) '()]
    [else (make-letter-list dict LETTERS)]))
  
(define (make-letter-list dict lets)
  (cond
    [(empty? lets) '()]
    [(= 0 (starts-with (first lets) dict)) (make-letter-list dict (rest lets))]
    [else (cons (make-letter-count (first lets) (starts-with (first lets) dict))
                (make-letter-list dict (rest lets)))]))

;most-frequent
; dictionary -> letter-count
;(check-expect (most-frequent SmallDict)
;              (make-letter-count "a" 4))
;(check-expect (most-frequent '()) '())
;(define (most-frequent dict)
;  (highest-in-list (count-by-letter dict)))

;highest-in-list
;alolc -> letter-count
;(check-expect (highest-in-list (count-by-letter SmallDict))
 ;             (make-letter-count "a" 4))
;(define (highest-in-list alolc)
;  (cond
;    [(empty? alolc) '()]
;    [(empty? (rest alolc)) (first alolc)]
;    [else (highest-in-list (highest-helper (first alolc) (rest alolc)))]))

;highest-helper
;letter-count alolc -> alolc
;will cons either the letter-count or the first of the alolc (whichever is highest) to the rest of the alolc
;(check-expect (highest-helper (make-letter-count "a" 4) (count-by-letter (rest SmallDict)))
;              (list (make-letter-count "a" 4) (make-letter-count "c" 1)))
;(check-expect (highest-helper (make-letter-count "z" 3) '())
;              (list (make-letter-count "z" 3)))
(define (highest-helper letCount alolc)
  (cond
    [(empty? alolc) (list letCount)]
    [(empty? (rest alolc))
     (if (> (letter-count-num letCount) (letter-count-num (first alolc)))
            (list letCount) alolc)] 
    [(> (letter-count-num letCount) (letter-count-num (first alolc)))
             (cons letCount (rest (rest alolc)))]
    [else alolc]))

;add-at-end
;o alos => alos
;adds an object to the end of a list
;(check-expect (add-at-end "alpha" '()) (list "alpha"))
;(check-expect (add-at-end 1 (list 2 3 4 (list 5))) (list 2 3 4 (list 5) 1))
(define (add-at-end o aloo)
  (cond
    [(empty? aloo) (list o)]
    [else (cons (first aloo) (add-at-end o (rest aloo)))]))

;add-to-end-of-last-list
;object alolos -> alolos
;Takes an object and a list of lists, and appends it to the end of the last child list
;(check-expect (add-to-end-of-last-list 5 (list (list 1 2) (list 3 4)))
;                                         (list (list 1 2) (list 3 4 5)))
;(check-expect (add-to-end-of-last-list 5 (list (list 1 2) (list 3 )))
;                                         (list (list 1 2) (list 3 5)))
;(check-expect (add-to-end-of-last-list 5 (list (list 1 2)))
;                                         (list (list 1 2 5)))
;(check-expect (add-to-end-of-last-list 5 (list '() '()))
;                                       (list '() (list 5)))
;(check-expect (add-to-end-of-last-list 5 (list '())) (list (list 5)))
(define (add-to-end-of-last-list o alolos)
  (cond
    [(empty? alolos) "empty alolos"]
    [(= (length alolos) 1) (list (add-at-end o (first alolos)))]
    [else (add-at-end (add-at-end o (last alolos)) (all-but-last alolos))]))

;all-but-last
;list -> list
;Takes a list. if it has 9 items, it returns a list with the first 8.
;(check-expect (all-but-last (list 1 2 3 4)) (list 1 2 3))
;(check-expect (all-but-last '()) '())
;(check-expect (all-but-last (list 1)) '())
;(check-expect (all-but-last (list (list 1) (list 2)))
;              (list (list 1)))
;(check-expect (all-but-last (list (list 1) (list 2) (list 3)))
;              (list (list 1) (list 2)))


(define (all-but-last alos)
  (cond
    [(empty? alos) '()]
    [(empty? (rest alos)) '()]
    [else (cons (first alos) (all-but-last (rest alos)))]))
    
;*** words-by-first-letter
;dictionary -> alod
(check-expect (words-by-first-letter SmallDict)
              (list (list "alpha" "aggro" "anvil" "atom") (list "beta") (list "cornholio")))
(check-expect (words-by-first-letter (list "alpha" "beta" "boobie"))
                                     (list (list "alpha") (list "beta" "boobie")))
(define (words-by-first-letter dict)
  (cond
    [(empty? dict) '()]
    [else (dictionaries-builder (first dict) "a" (list '()) (rest dict))]))


;** last
; alos -> object
;gets the last item from a list
;(check-expect (last (list 1 2 3)) 3)
;(check-expect (last (list 1)) 1)
;(check-expect (last '()) '())
(define (last aloa)
  (cond
    [(empty? aloa) '()]
    [(empty? (rest aloa)) (first aloa)]
    [else (last (rest aloa))]))

;***dictionaries-builder
;string 1String alolos alos
;takes a word, the letterIP, the output in progress, and the remaining input words -> a list of word lists for each letter of the alphabet.
;goes letter by letter. Starts at a. ends after z.
(check-expect (dictionaries-builder "alpha" "a" (list '()) (rest SmallDict))
              (list (list "alpha" "aggro" "anvil" "atom") (list "beta") (list "cornholio")));
(check-expect (dictionaries-builder "anvil" "a" (list (list "alpha" "aggro")) (list "atom" "beta" "cornholio"))
              (list (list "alpha" "aggro" "anvil" "atom") (list "beta") (list "cornholio")))
(check-expect (dictionaries-builder "beta" "a" (list (list "alpha" "aggro" "anvil" "atom")) '())
              (list (list "alpha" "aggro" "anvil" "atom") (list "beta")))
(define (dictionaries-builder newArg letterIP alolos remainingDict)
  (cond
    ;last entry
    [(empty? remainingDict) (if (same-letter newArg letterIP)
                                (add-to-end-of-last-list newArg alolos)
                                (add-at-end (list newArg) alolos))]
    ;first entry in a letter
    [(not (same-letter newArg letterIP))
        (dictionaries-builder newArg (next-letter letterIP) (add-at-end '() alolos) remainingDict)]
    ;additional word to that dictionary
    [else (dictionaries-builder (first remainingDict) letterIP (add-to-end-of-last-list newArg alolos) (rest remainingDict))]))

;next-letter
;1String -> 1String
; given n -> returns o
(check-expect (next-letter "n") "o")
(check-expect (next-letter "z") "{")
(define (next-letter in)
  (string (integer->char (+ 1 (char->integer (string-ref in 0))))))

;same-letter
;string string -> bool
;if first and second are the same, true
(define (same-letter w1 w2)
  (string=? (first (explode w1)) (first (explode w2))))

(words-by-first-letter AS-LIST)

;** others-with-this-letter
;string dictionary -> alos
;(check-expect (others-with-this-letter "aardvark" SmallDict)
;              (list "aardvark" "alpha" "aggro" "anvil" "atom"))
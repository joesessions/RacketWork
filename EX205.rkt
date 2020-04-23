;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname EX205) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/itunes)


(define ITUNES-LOCATION "/Users/joesessions/RacketWork/MusicLibrary2.xml")
 
; LLists
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))


; An LLists is one of:
; – '()
; – (cons LAssoc LLists)
 
; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)
;
(define LAssoc1 (list (list "Track ID" 2009) (list "Name" "Red Red Wine")))
(define LAssoc2 (list (list "Track ID" 2006) (list "Name" "All Eyes")))
(define LLists (list LAssoc1 LAssoc2))
(define LAssoc3 (list (list "Good?" true) (list "Main Keyboard Riff?" false)))
(define LAssoc4 (list (list "Suck?" true) (list "Main Keyboard Riff?" false)))
(define LListsEx (list LAssoc3 LAssoc4 LAssoc1 LAssoc2 ))

;boolean-attributes
;LLists > alos
;(check-expect (boolean-attributes LLists) '())
(check-expect (boolean-attributes LListsEx) (list "Good?" "Suck?" "Main Keyboard Riff?"))
(check-expect (boolean-attributes '()) '())
(define (boolean-attributes ll)
  (create-set (de-list-ify (booleans-as-alol ll))))

;booleans-as-alol
(define (booleans-as-alol ll)
 (cond
    [(empty? ll) '()]
    [(empty? (get-bools (first ll))) (booleans-as-alol (rest ll))]
    [else (cons (get-bools (first ll)) (booleans-as-alol (rest ll)))]))

;LAssoc (one song worth) > alos (the boolean keys)
(check-expect (get-bools (list (list "key" 01) (list "key2" true))) (list "key2"))
(define (get-bools la)
  (cond
    [(empty? la) '()]
    [(boolean? (second (first la))) (cons (first (first la)) (get-bools (rest la)))]
    [else (get-bools (rest la))]))

;de-list-ify
;alol >aloo
(check-expect (de-list-ify (list (list 1 2) (list 3 4))) (list 1 2 3 4))
(check-expect (de-list-ify (list (list 1 2) '() (list 3 4))) (list 1 2 3 4))
(check-expect (de-list-ify (list '() '())) '())
(check-expect (de-list-ify (list '())) '())
(define (de-list-ify alol)
  (cond
    [(empty? alol) '()]
    [(empty? (first alol)) (de-list-ify (rest alol))]
    [(empty? (first (first alol))) (de-list-ify (rest alol))]
    [else (cons (first (first alol)) (de-list-ify (cons (rest (first alol)) (rest alol))))]))
              

;time is 4 ints: h min s ms, which add up to an expression of time in human-readable form.
(define-struct time [h min s ms])

;total-time/list
;LTracks > time
(check-expect (total-time/list '()) 0)
(define (total-time/list lt)
  (cond
    [(empty? lt) 0]
    [else (+ (second (find-association "Total Time" (first lt) 0)) (total-time/list (rest lt)))]))

;find-association
;string LAssoc Any > Assoc
;It produces the first Association whose first item is equal to key, or default if there is no such Association.
(check-expect (find-association "Track ID" LAssoc1 "Nope")
              (list "Track ID" 2009))
(check-expect (find-association "Guitarist" LAssoc1 "Nope")
              "Nope")
(check-expect (find-association "Track ID" '() "Nope") "Nope")
(define (find-association key la default)              
   (cond
     [(empty? la) default]
     [(string=? key (first (first la))) (first la)]
     [else (find-association key (rest la) default)]))

; An Association is a list of two items: 
;   (cons String (cons BSDN '()))
 
; A BSDN is one of: 
; – Boolean
; – Number
; – String
; – Date
 
; String -> LLists
; creates a list of lists representation for all tracks in 
; file-name, which must be an XML export from iTunes 

;ms>display
;ms > Human-readable string
(check-expect (ms>display 123) "00:00:00.123")
(check-expect (ms>display 3600000) "01:00:00.000")
(define (ms>display ms)
  (string-append (n>s 2 (time-h (ms>time ms))) ":"
                 (n>s 2 (time-min (ms>time ms))) ":"
                 (n>s 2 (time-s (ms>time ms))) "."
                 (n>s 3 (time-ms (ms>time ms)))))

;n>s
; num num > s
; first number is the number of desired digits, second is the number.
(check-expect (n>s 2 1) "01")
(check-expect (n>s 3 1) "001")
(check-expect (n>s 3 123) "123")
(check-expect (n>s 2 12) "12")
(check-expect (n>s 10 1) "0000000001")
(define (n>s len arg)
  (cond
    [(= (string-length (number->string arg)) len)
        (number->string arg)]
    [else (string-append "0" (n>s (- len 1) arg))]))

;ms->time
;int-> string
(check-expect (ms>time 123) (make-time 00 00 00 123))
(check-expect (ms>time 12345) (make-time 00 00 12 345))
(check-expect (ms>time 70000) (make-time 00 01 10 000))
(check-expect (ms>time 3600000) (make-time 01 00 00 000))
(define (ms>time ms)
  (make-time
   (/ (- (modulo ms 216000000) (modulo ms 3600000)) 3600000)
   (/ (- (modulo ms 3600000) (modulo ms 60000)) 60000)
   (/ (- (modulo ms 60000) (modulo ms 1000)) 1000)
   (modulo ms 1000)))

; create-set
; alos > alos
(check-expect (create-set (list "a" "a" "b")) (list "a" "b"))
(check-expect (create-set (list "a" "b" "b")) (list "a" "b"))
(define (create-set alos)
  (cond
    [(empty? alos) '()]
    [(contains? (first alos) (rest alos)) (create-set (rest alos))]
    [else (cons (first alos) (create-set (rest alos)))]))

; contains?
; s alos > bool
(check-expect (contains? "a" (list "a")) true)
(check-expect (contains? "a" (list "a" "b")) true)
(check-expect (contains? "a" (list "c" "b")) false)
(check-expect (contains? "a" '()) false)
(check-expect (contains? "a" (list "a" "a")) true)

(define (contains? s alos)
  (cond
   [(empty? alos) false]
   [(empty? s) false]
   [(string=? s (first alos)) true]
   [else (contains? s (rest alos))]))


;(ms>display (total-time/list list-tracks))
(boolean-attributes list-tracks)
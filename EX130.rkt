;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX130) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(cons "Krishnamurthi" (cons "Flatt" '()))




;EX130:
; A List-of-names is one of:
; - '()
; - (cons String List-of-names)
(cons "Smith" (cons "Tedder" (cons "Samueleth" (cons "Whaddup" (cons "Roger" '())))))

;EX131
; a List-of-booleans is one of:
; - '()
; - (cons Boolean List-of-booleans)

; contains-flatt?
; List-of-names -> Boolean
; determines whether "Flatt" is in the List-of-names
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(string=? (first alon) "Flatt") #true]
    [else (contains-flatt? (rest alon))]))


(contains-flatt?
  (cons "A" (cons "B" (cons "C" '()))))

(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Find" '())) #false)
(check-expect (contains-flatt? (cons "Flatt" '())) #true)
(check-expect (contains-flatt? (cons "Fruit" (cons "Flatt" (cons "Fuego" '())))) #true)
(check-expect (contains-flatt? (cons "Flatt" (cons "Fruit" (cons "Fuego" '())))) #true)
(check-expect (contains-flatt? (cons "Flatty" (cons "Fruit" (cons "Fuego" '())))) #false)
(check-expect (contains-flatt?
               (cons "Fagan"
                     (cons "Findler"
                           (cons "Fisler"
                                 (cons "Flanagan"
                                       (cons "Flatt"
                                             (cons "Felleisen"
                                                   (cons "Friedman" '())))))))
               ) #true)


;********* contains?
;string list -> boolean
;
(define (contains? str a-list)
    (cond
    [(empty? a-list) #false]
    [(string=? (first a-list) str) #true]
    [else (contains? str (rest a-list))]))

(check-expect (contains? "Flatt" '()) #false)
(check-expect (contains? "Flatt" (cons "Find" '())) #false)
(check-expect (contains? "Flatt" (cons "Flatt" '())) #true)
(check-expect (contains? "Flatt" (cons "Fruit" (cons "Flatt" (cons "Fuego" '())))) #true)
(check-expect (contains? "Flatt" (cons "Flatt" (cons "Fruit" (cons "Fuego" '())))) #true)
(check-expect (contains? "Flatt" (cons "Flatty" (cons "Fruit" (cons "Fuego" '())))) #false)
(check-expect (contains? "Flatt"
               (cons "Fagan"
                     (cons "Findler"
                           (cons "Fisler"
                                 (cons "Flanagan"
                                       (cons "Flatt"
                                             (cons "Felleisen"
                                                   (cons "Friedman" '())))))))
               ) #true)

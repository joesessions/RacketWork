;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |EX 187|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points


(define Minny (make-gp "Minny" 4))
(define Meddy (make-gp "Meddy" 5))
(define Max (make-gp "Max" 9))



;PlayerRank
;List of GamePlayer -> List of GamePlayer
;Takes a list of gameplayers and sorts them
(check-expect (PlayerRank (list Minny Meddy Max))
              (list Max Meddy Minny))
(check-expect (PlayerRank (list Max)) (list Max))
(check-expect (PlayerRank '()) '())
(check-expect (PlayerRank (list Max Meddy Minny))
              (list Max Meddy Minny))
(check-expect (PlayerRank (list Meddy Max))
              (list Max Meddy))

(define (PlayerRank alog)
  (cond
    [(empty? alog) '()]
    [(empty? (rest alog)) alog]
    [else (InsertPlayer (first alog) (PlayerRank (rest alog)))]))

;FirstBetter?
;GamePlayer GamePlayer -> bool
;takes two players and returns true if first has higher score than second
(check-expect (FirstBetter Max Meddy) true)
(check-expect (FirstBetter Meddy Max) false)
(check-expect (FirstBetter Max Max) true)
(define (FirstBetter gp1 gp2)
  (>= (gp-score gp1) (gp-score gp2)))

;insertPlayer
;gp alog -> alog
;takes a list of gameplayers inserts the player in the correct place.
(check-expect (InsertPlayer Meddy (list Max Minny)) (list Max Meddy Minny))
(check-expect (InsertPlayer Max (list Meddy Minny)) (list Max Meddy Minny))
(check-expect (InsertPlayer Minny (list Max Meddy)) (list Max Meddy Minny))
(check-expect (InsertPlayer Minny (list Minny)) (list Minny Minny))
(define (InsertPlayer gp1 alog)
  (cond
   [(empty? alog) (list gp1)]
   [(> (gp-score gp1) (gp-score (first alog))) (cons gp1 alog)] ;Do I got this right?
   [else (cons (first alog) (InsertPlayer gp1 (rest alog)))]))
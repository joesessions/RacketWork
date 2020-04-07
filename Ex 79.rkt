;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ex 79|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;H is a number between 0 and 100
; examples 0, 1, 2, 10, 99, 100

(define-struct person [fstname lstname male?])
; A Person is a structure:
;  (make-person String String Boolean)
; examples :  Jon Apple true
; Suzie Louise false
; Billy Joe Blah true

(define-struct dog [owner name age happiness])
; A Dog is a structure
; Interpretation: represents a dog by its owner, the pet's own name, age and happiness.
; (make-dog person String PositiveInteger H)
; ex: (make-dog JimStone Fido 4 70)
; ex: (make-dog JoeSessions Charlie 5 45)
; ex: (make-dog HalSessions Khaki 8 65)

; A Weapon is one of:
; - #false
; - Posn
(define-struct Weapon [status])
; (make-Weapon [#false or Posn])
; ex: (make-Weapon #false)
; ex: (make-Weapon (make-posn 34 3))
; ex: (make-Weapon (make-posn 5 20))
; Interpretation: shows that the missile is either unlaunched (#false) or
; has a position in flight, given by the Posn
; 


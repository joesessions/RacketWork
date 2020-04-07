;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname DataDefinitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Data definitions for each Structure-Type definitions.

(define-struct movie [title producer year])

; movie is (make-movie string string number)  data def

(define-struct person [name hair eyes phone])

; person is (make-person string string string string)

(define-struct pet [name number])

; pet is (make pet string number)

(define-struct CD [artist title price])

; cd is (make-cd string string number)

(define-struct sweater [material size producer])

; sweater is (make-sweater string number string)

(define-struct time-since-midnight [hours minutes seconds])

; time-since-midnight is (make-time-since-midnight number number number)

(define-struct word [firstL secondL thirdL])

; word is (make-word 1String 1String 1String)


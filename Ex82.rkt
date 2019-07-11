;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct word [firstL secondL thirdL])

; word is (make-word 1String 1String 1String)

; word word -> word or #false
; word-comparer takes two words and if they are the same, returns the word. Otherwise, returns false.
(define (word-comparer w1 w2) (if (and (and (string=? (word-firstL w1) (word-firstL w2))
                              (string=? (word-secondL w1) (word-secondL w2)))
                              (string=? (word-thirdL w1) (word-thirdL w2))) w1 #false))

(check-expect (word-comparer (make-word "t" "y" "l") (make-word "t" "y" "l")) (make-word "t" "y" "l"))
(check-expect (word-comparer (make-word "t" "y" "l") (make-word "t" "y" "s")) #false)


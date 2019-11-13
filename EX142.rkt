;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX142) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

;;  EX141
; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) '())
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")
 
(define (cat l)
  (cond
    [(empty? l) '()]
    [else (string-append (first l)
                         (cond
                           [(empty? (rest l)) ""]
                           [else (cat (rest l))]))]))


;**** ill-sized
;list-of-images (loi) and number -> false or image.
(check-expect (ill-sized (cons (empty-scene 30 30) '()) 30) false)
(check-expect (ill-sized (cons (empty-scene 30 30) (cons (empty-scene 30 25) '())) 30) #false)

(define (ill-sized loi num)
  (cond
    [(empty? loi) false]
    [(and (not (= (image-height (first loi)) num))
          (not (= (image-width (first loi)) num))) (first loi)]
    [else (ill-sized (rest loi) num)]))



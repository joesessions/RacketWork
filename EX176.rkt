;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX176) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Matrix -> Matrix
; transposes the given matrix along the diagonal 
 
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

(define 2row1 (cons 11 (cons 12 (cons 13 '()))))
(define 2row2 (cons 21 (cons 22 (cons 23 '()))))
(define 2row3 (cons 31 (cons 32 (cons 33 '()))))
(define mat2 (cons 2row1 (cons 2row2 (cons 2row3 '()))))

(define 2wor1 (cons 11 (cons 21 (cons 31 '()))))
(define 2wor2 (cons 12 (cons 22 (cons 32 '()))))
(define 2wor3 (cons 13 (cons 23 (cons 33 '()))))
(define tam2 (cons 2wor1 (cons 2wor2 (cons 2wor3 '()))))
  
(check-expect (transpose mat1) tam1)
(check-expect (transpose mat2) tam2)
  
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
[else (cons (first* lln) (transpose (rest* lln)))]))

; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)

;first*, which consumes a matrix and produces the first column as a list of numbers; and
(check-expect (first* mat1) (cons 11 (cons 21 '())))

(define (first* mat)
  (cond
    [(empty? mat) '()]
    [else (cons (first (first mat))
         (first* (rest mat)))]))

;rest*, which consumes a matrix and removes the first column. The result is a matrix.
(check-expect (rest* mat1) (cons (cons 12 '()) (cons (cons 22 '()) '())))

(define (rest* mat)
  (cond
    [(empty? mat) '()]
    [else (cons (rest (first mat))
           (rest* (rest mat)))]))

             
  

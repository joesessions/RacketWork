;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |EX233 unquote splice etc|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)




;`(1 ,(+ 1 1) 3)	;
;(quasiquote (1 (unquote (+ 1 1)) 3))
;(quasiquote (1 2 3))
;(list `1 `,(+ 1 1) `3)
;(list (quasiquote 1) (quasiquote (unquote (+ 1 1) )) (quasiquote 3))
;(cons 1 (list 2 3 4))

;make a cell from a number
;number -> nested list
(define (make-cell num)
  `(td ,(number->string num)))
(define (make-row lon)
  (cond
    [(empty? lon) '()]
    [else (cons (make-cell (first lon))
                (make-row (rest lon)))]))


; List-of-numbers List-of-numbers -> ... nested list ...
; creates an HTML table from two lists of numbers 
(define (make-table row1 row2)
  `(table ((border "1"))
          (tr ,@(make-row row1))
          (tr ,@(make-row row2))))




`(0 ,@'(1 2 3) 4)
(list 0 1 2 3 4)

;this table-like shape:
(check-expect
`(("alan" ,(* 2 500))
  ("barb" 2000)
  (,@'("carl" ", the great")   1500)
  ("dawn" 2300))
(list (list "alan" (* 2 500))
      (list "barb" 2000)
      (list "carl" ", the great" 1500)
      (list "dawn" 2300))
)


;and this third web page:
`(html
   (body
     (table ((border "1"))
       (tr ((width "200"))
         ,@(make-row '( 1  2)))
       (tr ((width "200"))
         ,@(make-row '(99 65))))))
(list 'html (list 'body (list 'table (list (list 'border "1"))
                              (list 'tr (list (list 'width "200")) (list 'td "1") (list 'td "2"))
                              (list 'tr (list (list 'width "200")) (list 'td "99") (list 'td "65"))
                              )))
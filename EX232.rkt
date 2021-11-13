;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname EX232) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
(require 2htdp/web-io)

; Ranking
; los -> loo with ranks applied
; reverses the list to get the ranks correctly applied.
(check-expect (ranking (list "4" "5")) `((1 "4") (2 "5")))
(define (ranking los)
  (reverse (add-ranks (reverse los))))

; add-ranks
; los-> loo
; takes a list and adds a length numbers to it
(check-expect (add-ranks (list "4" "5")) `((2 "4") (1 "5")))
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (number->string (length los)) (first los))
                (add-ranks (rest los)))]))

;make a cell from a number
;number -> nested list
(define (make-cell str)
  `(td str))
(define (make-row lon)
  (cond
    [(empty? lon) '()]
    [else (cons (make-cell (first lon))
                (make-row (rest lon)))]))


; List-of-numbers List-of-numbers -> ... nested list ...
; creates an HTML table from two lists of numbers 
;(define (make-table lor)
 ; (cons (table `((border "1"))
  ; (cond
   ;  [(empty? lor) '()]
    ; [else (cons (list tr (make-row ,@(first lor)))
     ;     (make-table ,@(rest lor)))])))
;(make-table '(("1" "2") ("3" "4")))

(define table-1 (list (list 'h1 "title") (list 'p "A second web page")))
(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

(check-expect (add-tds (list "1" "2")) (list (list 'td "1") (list 'td "2")))
(define (add-tds los)
  (cond
          [(empty? los) '()]
          [else (cons (list 'td (first los))
                  (add-tds (rest los)))]))



;(check-expect (add-row-syntax `(("1" "2") ("3" "4"))) `( ( tr  ( 'td "1") ( 'td "2")) ( 'tr ( 'td "3") (td "4"))))
;`(((td "1") (td "2")) ((td "3") (td "4")))
;"first"
;(first `(((td "1") (td "2")) ((td "3") (td "4"))))
;(cons 'tr (first `(((td "1") (td "2")) ((td "3") (td "4")))))
;(cons 'tr (add-tds (first `(((td "1") (td "2")) ((td "3") (td "4"))))))
;(cons 'tr (add-tds (list (list 'td "1") (list 'td "2"))))
;(check-expect (add-trs (list (
(check-expect (add-row-syntax `(("1" "2") ("3" "4")))
              `((tr (td "1") (td "2")) (tr (td "3") (td "4"))))
(define (add-row-syntax loo)
  (cond
    [(empty? loo) '()]
    [else (cons (cons 'tr (add-tds (first loo)))
                (add-row-syntax (rest loo)))]))

"input"
(list "1" "2")

"output"
(list (list 'td "1") (list 'td "2"))


  


(show-in-browser
`(html
   (head
     (title ,"title"))
   (body
    (table ((border "1"))  ,@(add-row-syntax (ranking one-list))))))
     ;;;;,@table-1)))



;(show-in-browser `(html (body ,(make-table `(("2" "3") ("4" "5"))))))

;make-table
;lor (list of rows) -> make html table with border 1

;make-r
;(list 'html (list 'head (list 'title "title")) (list 'body (list 'table (list (list 'border "1")) (list (list (list 'tr (list 'td 1) (list 'td "Asia: Heat of the Moment"))
 ;                                                                                                             (list 'tr (list 'td 2) (list 'td "U2: One"))
  ;                                                                                                            (list 'tr (list 'td 3) (list 'td "The White Stripes: Seven Nation Army")))))))
;
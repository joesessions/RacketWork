;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Old thing|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; Define sorted>?
; takes a list of numbers and returns whether they are in descending order.
(check-expect (sorted>? (list 123 100 50 40 20)) true)
(check-expect (sorted>? (list 5 4 3)) true)
(check-expect (sorted>? (list 5 3 4)) false)
(check-expect (sorted>? (list 1)) true)
(check-expect (sorted>? (list -4 200)) false)


(define (sorted>? alon)
  (cond
    [(empty? (rest alon)) true]
    [else
     (if (> (first alon) (first (rest alon))) 
     (sorted>? (rest alon)) false)]))

(check-expect (cons 1 '())
              (list 1))

(check-expect (cons 1 (cons 2 (cons 3 '())))
              (list 1 2 3))
   

(check-expect
(cons "a" (cons "b" (cons "c" (cons "d" '()))))
(list "a" "b" "c" "d"))

(check-expect
(cons (cons 1 (cons 2 '())) '())
(list (list 1 2)))

(check-expect
(cons "a" (cons (cons 1 '()) (cons #false '())))
(list "a" (list 1) false))

(check-expect
(cons (cons "a" (cons 2 '())) (cons "hello" '()))
(list (list "a" 2) "hello"))

(check-expect
(cons (cons 1 (cons 2 '()))
      (cons (cons 2 '())
            '()))
(list (list 1 2) (list 2)))

(check-expect
(cons "a" (list 0 #false))
(list "a" 0 #false))

(check-expect
(list (cons 1 (cons 13 '())))
(list (list 1 13)))

(check-expect
(cons (list 1 (list 13 '())) '())
(list (list 1 (list 13 '()))))

(check-expect
(list '() '() (cons 1 '()))
(list '() '() (list 1)))

(check-expect
(cons "a" (cons (list 1) (list #false '())))
(list "a" (list 1) #false '()))


(check-expect
(cons "a" (list 0 #false))
(cons "a" (cons 0 (cons #false '()))))

(check-expect
(list (cons 1 (cons 13 '())))
(cons (cons 1 (cons 13 '())) '()))

(check-expect
(cons (list 1 (list 13 '())) '()) 
(cons (cons 1 (cons (cons 13 (cons '() '())) '())) '()))

(check-expect
(list '() '() (cons 1 '()))
(cons '() (cons '() (cons (cons 1  '()) '()))))

(check-expect
(cons "a" (cons (list 1) (list #false '())))
(cons "a" (cons (cons 1 '()) (cons #false (cons '() '())))))
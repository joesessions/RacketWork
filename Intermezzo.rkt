;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Intermezzo) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(require htdp/web-io) 

 (require 2htdp/web-io)


'(1 "a" 2 #false 3 "c")
;(list 1 "a" 2 #false 3 "c")

(cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '()))))))

'()
;(list )

'(("alan" 1000)
  ("barb" 2000)
  ("carl" 1500))

(list (list "alan" 1000) (list "barb" 2000) (list "carl" 1500))
(cons (cons "alan" (cons 1000 '())) (cons (cons "barb" (cons 2000 '())) (cons (cons "carl" (cons 1500 '())) '())))

(define x 42)

'(41 x 43 44)

(list 41 x 43 44)

'(1 (+ 1 1) 3)
(list 1 (+ 1 1) 3)


`(1 (+ 1 1) 3)
`(1 ,(+ 1 1) 3)
(quasiquote(1 ,(+ 1 1) 3))
(quasiquote(1 (unquote (+ 1 1)) 3))
`( ,3 ,3)




; String String -> ... deeply nested list ...
; produces a web page with given author and title
(define (my-first-web-page author title)
  `(html
     (head
       (title ,title)
       (meta ((http-equiv "content-type")
              (content "text-html"))))
     (body
       (h1 ,title)
       (p "I, " ,author ", made this page."))))

;(show-in-browser;
;(my-first-web-page "Matthias" "Hello World"))


`(1 "a" 2 #false 3 "c")
(list 1 "a" 2 #false 3 "c")


;this table-like shape:
`(("alan" ,(* 2 500))
  ("barb" 2000)
  (,(string-append "carl" " , the great") 1500)
  ("dawn" 2300))

(list (list "alan" (* 2 500))
      (list "barb" 2000)
      (list (string-append "carl" " , the great") 1500)
      (list "dawn" 2300))
;and this second web page:

(define title "ratings")
;(show-in-browser;
;`(html
 ;  (head
 ;    (title ,title))
 ;  (body
 ;    (h1 ,title)
 ;    (p "A second web page"))))
;(list 'html (list 'head (list 'title title)) (list 'body (list 'h1 title) (list 'p "A second web page")))
;where (define title "ratings")

(check-expect (make-row '(2 3 4))
                        '("2" "3" "4"))

(define (make-row ls)
  (cond
    [(empty? ls) '()]
    [else (cons (number->string (first ls)) (make-row (rest ls)))]))

`(tr ,@(make-row '(3 4 5)))

`(tr ,@(make-row '(3 4 5)))


`(0 ,@'(1 2 3) 4)
(list 0 1 2 3 4)
;this table-like shape:
`(("alan" ,(* 2 500))
  ("barb" 2000)
  (,@'("carl" " , the great")   1500)
  ("dawn" 2300))
(list (list "alan" 1000)
      (list "barb" 2000)
      (list "carl , the great" 1500)
      (list "dawn" 2300))

;and this third web page:
(show-in-browser `(html
   (body
     (table ((border "1"))
       (tr ((width "200"))
         ,@(make-row '( 1  2)))
       (tr ((width "200"))
         ,@(make-row '(99 65)))))))
(show-in-browser
(list 'html (list 'body (list 'table (list (list 'border 1)) (list 'tr (list (list 'width 200)) "1" "2")
                              (list 'tr (list (list 'width 200)) "99" "65"))))
)

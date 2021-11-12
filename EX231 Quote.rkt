;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |EX231 Quote|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
(require 2htdp/web-io)

;'(1 "a" 2 #false 3 "c")
;(list 1 "a" 2 #false 3 "c")
;(cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '()))))))


;'()

;'(("alan" 1000)
 ; ("barb" 2000)
  ;("carl" 1500))

;(list (list "alan" 1000) (list "barb" 2000) (list "carl" 1500))

;(cons (cons "alan" (cons 1000 '())) (cons (cons "barb" (cons 2000 '())) (cons (cons "carl" (cons 1500 '())) '())))

;(define x 42)

;'(40 41 x 43 44)

;'(1 (+ 1 1) 3)
;(cons 1 (cons (cons '+ (cons 1 (cons 1'()))) (cons 3'())))

; String String -> ... deeply nested list ...
; produces a web page with given author and title
(define (my-first-web-page author title)
  `(html
     (head
       (title title)
       (meta ((http-equiv "content-type")
              (content "text-html"))))
     (body
       (h1 title)
       (p "I, " author ", made this page."))))

(show-in-browser (my-first-web-page "Joe" "Who made who?"))

`(1 ,(+ 1 1) 3)
(list 1 (+ 1 1) 3)

`(1 "a" 2 #false 3 "c")
(list 1 "a" 2 #false 3 "c")
(cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '()))))))


;;this table-like shape:
`(("alan" ,(* 2 500))
  ("barb" 2000)
  (,(string-append "carl" " , the great") 1500)
  ("dawn" 2300))

(list (list "alan" (* 2 500)) (list "barb" 2000) (list (string-append "carl" ", the great") 1500) (list "dawn" 2300))
(cons (cons "alan" (cons (* 2 500) '())) (cons (cons "barb" (cons 2000 '())) (cons (cons (string-append "carl" ", the great") (cons 1500 '()))
      (cons (cons "dawn" (cons 2300 '())) '()))))

;and this second web page:
;(show-in-browser
;`(html
 ;  (head
  ;   (title ,"title"))
  ; (body
   ;  (h1 ,"title")
    ; (p "A second web page"))))

;(list 'html (list 'head (list 'title "title"))
 ;           (list 'body (list 'h1 "title")
  ;                      (list 'p "A second web page")))



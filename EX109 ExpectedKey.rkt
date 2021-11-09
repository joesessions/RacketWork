;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX109 ExpectedKey|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
(require racket/format)

(define WR (empty-scene 100 100))
(define YR (empty-scene 100 100 "yellow"))
(define GR (empty-scene 100 100 "green"))
(define RR (empty-scene 100 100 "red"))

;ws is one of AA, BB, DD, ER, END
;ws is a string

;***update-ke
;if the ws is AA, and the ke is a the ws becomes BB
(define (update-ke ws ke) 
	(cond
		[(string=? ws "AA") 
		(cond
			[(string=? ke "a") "BB"]
			[else "ER"])]
		[(string=? ws "BB")
		(cond
			[(or (string=? ke "b") (string=? ke "c")) "BB"]
			[(string=? ke "d") "DD"]
			[else "ER"])]
                [(or (string=? ws "ER") (string=? ws "DD")) "END"]       
		))

(check-expect (update-ke "AA" "a") "BB")
(check-expect (update-ke "AA" "b") "ER")
(check-expect (update-ke "AA" "r") "ER")
(check-expect (update-ke "BB" "b") "BB")
(check-expect (update-ke "BB" "c") "BB")
(check-expect (update-ke "BB" "a") "ER")
(check-expect (update-ke "BB" "r") "ER")
(check-expect (update-ke "BB" "d") "DD")
(check-expect (update-ke "ER" "q") "END")


;***main
;ws -> ws
;runs the program
(define (main ws)
 (big-bang ws
  [on-key update-ke]
  [to-draw render]
  [stop-when end?]))

;wishlist
;end?
(define (end? ws)
  (cond
    [(string=? ws "END") #true]
    [else #false]))

(check-expect (end? "END") #true)
(check-expect (end? "DD") #false)
(check-expect (end? "BB") #false)

;render

(define (render ws) 
	(cond
		[(string=? ws "AA") WR]
		[(string=? ws "BB") YR]
		[(string=? ws "DD") GR]
		[(string=? ws "ER") RR]
		))

(main "AA")
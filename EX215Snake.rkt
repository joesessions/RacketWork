;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname EX215Snake) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define GAMESPEED 2)
(define SEGRADIUS 5)
(define MAXDIMENSION 50)
(define SCNWDT (+ 2 (* 2 SEGRADIUS MAXDIMENSION)))
(define SCNHGT (+ 2 (* 2 SEGRADIUS MAXDIMENSION)))
(define MTSCN (empty-scene SCNWDT SCNHGT))
(define TICK 1)

;a losegs (list of segments) is either:
; '()
; (cons posn (losegs))

;***move-worm
;np lop > lop
;takes a list of posn, adds a new posn and returns all but the last
(check-expect (move-worm (make-posn 15 5) (list (make-posn 20 5) (make-posn 25 5)))
              (list (make-posn 15 5) (make-posn 20 5))) 
(define (move-worm np lop)
  (cons np (all-but-last lop)))

;***all-but-last
;lop > lop
;takes a list of posn, removes the last one
(check-expect (all-but-last (list (make-posn 15 5) (make-posn 20 5) (make-posn 25 5) (make-posn 30 5)))
              (list (make-posn 15 5) (make-posn 20 5) (make-posn 25 5)))
(define (all-but-last lop)
  (cond
    [(empty? lop) '()]
    [(empty? (rest lop)) '()]
    [else (cons (first lop) (all-but-last (rest lop)))]))

(define SEG (circle SEGRADIUS "solid" "red"))
;x y refer to the coordinate in pixels.
(define-struct ws [posn dir])

(define (render w)
  (place-image SEG
               (posn-x (ws-posn w)) (posn-y (ws-posn w))
               MTSCN))

;update-tick
;every clock tick, marches the snake forward.
;directions: 0 right, 1 down, 2 left, 3 up
(check-expect (update-tick (make-ws (make-posn 6 6) 0))
              (make-ws (make-posn 16 6) 0))
(define (update-tick w)
  (cond
    [(= (ws-dir w) 0) (make-ws (make-posn (+ (* 2 SEGRADIUS) (posn-x (ws-posn w))) (posn-y (ws-posn w))) 0)]
    [(= (ws-dir w) 1) (make-ws (make-posn (posn-x (ws-posn w)) (+ (* 2 SEGRADIUS) (posn-y (ws-posn w)))) 1)]
    [(= (ws-dir w) 2) (make-ws (make-posn (- (posn-x (ws-posn w)) (* 2 SEGRADIUS)) (posn-y (ws-posn w))) 2)]
    [(= (ws-dir w) 3) (make-ws (make-posn (posn-x (ws-posn w)) (- (posn-y (ws-posn w)) (* 2 SEGRADIUS))) 3)]))

;update-key
;pressing an arrow key directs the snake.
(check-expect (update-key (make-ws (make-posn 50 50) 1) "left")
              (make-ws (make-posn 50 50) 2))
(define (update-key w ke)
  (cond
    [(and (string=? ke "right") (not (= (ws-dir w) 2))) (make-ws (make-posn (posn-x (ws-posn w)) (posn-y (ws-posn w))) 0)]
    [(and (string=? ke "down") (not (= (ws-dir w) 3))) (make-ws (make-posn (posn-x (ws-posn w)) (posn-y (ws-posn w))) 1)]
    [(and (string=? ke "left") (not (= (ws-dir w) 0))) (make-ws (make-posn (posn-x (ws-posn w)) (posn-y (ws-posn w))) 2)]
    [(and (string=? ke "up") (not (= (ws-dir w) 1))) (make-ws (make-posn (posn-x (ws-posn w)) (posn-y (ws-posn w))) 3)]
    [else w]))

;end?
;end if snakehead hits wall
(check-expect (end? (make-ws (make-posn 6 6) 2)) false)
(check-expect (end? (make-ws (make-posn -4 6) 2)) true)
(check-expect (end? (make-ws (make-posn 6 111116) 2)) true)
(check-expect (end? (make-ws (make-posn 6 -6) 2)) true)
(define (end? w)
  (or (< (posn-x (ws-posn w)) 0)
      (< (posn-y (ws-posn w)) 0)
      (> (posn-x (ws-posn w)) SCNWDT)
      (> (posn-y (ws-posn w)) SCNHGT)))

             

(define (main ws)
 (big-bang ws
  [on-tick update-tick]
  [on-key update-key]
  [to-draw render]
  [stop-when end?]))

;(main (make-ws (make-posn 5 5) 0))
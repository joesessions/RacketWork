;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname EX215Snake) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define GAMESPEED 2)
(define SEGRADIUS 5)
(define MAXDIMENSION 42)
(define SCNWDT (+ 2 (* 2 SEGRADIUS MAXDIMENSION)))
(define SCNHGT (+ 2 (* 2 SEGRADIUS MAXDIMENSION)))
(define MTSCN (empty-scene SCNWDT SCNHGT))
(define TICK 1)
(define lposn (list (make-posn 26 6) (make-posn 16 6) (make-posn 6 6)))

(define-struct ws [lposn dir tick])

;bonks-self
;lop > bool
; takes lop. If rest contains first, return true.
(check-expect (bonks-self lposn) false)
(check-expect (bonks-self (list (make-posn 26 6) (make-posn 16 6) (make-posn 6 6) (make-posn 26 6))) true)
(define (bonks-self lop)
   (cond
     [(empty? (rest lop)) false]
     [(and (= (posn-x (first lop)) (posn-x (second lop)))
           (= (posn-y (first lop)) (posn-y (second lop)))) true]
     [else (bonks-self (cons (first lop) (rest (rest lop))))]))

;***move-snake
;np lop > lop
;takes a list of posn, adds a new posn and returns all but the last. if ext (extend) = true, don't remove.
(check-expect (move-snake (make-posn 15 5) (list (make-posn 20 5) (make-posn 25 5)) true)
              (list (make-posn 15 5) (make-posn 20 5))) 
(define (move-snake np lop ext)
  (if ext
      (cons np (all-but-last lop))
      (cons np lop)))

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


;render
;ws > image
;takes the world state and plots all the segments on the mtscn
(define (render w)
  (cond
    [(empty? (ws-lposn w)) MTSCN]
    [else (place-image SEG
               (posn-x (first (ws-lposn w)))
               (posn-y (first (ws-lposn w)))
               (render (make-ws (rest (ws-lposn w)) (ws-dir w) (ws-tick w))))]))

;update-tick
;every clock tick, marches the snake forward.
;directions: 0 right, 1 down, 2 left, 3 up
(check-expect (update-tick (make-ws lposn 0 1))
              (make-ws (list (make-posn 36 6) (make-posn 26 6) (make-posn 16 6)) 0 2))
(define (update-tick w)
  (if (= (modulo (ws-tick w) 3) 0)
      (cond
        [(= (ws-dir w) 0) (make-ws (move-snake (make-posn (+ (* 2 SEGRADIUS) (posn-x (first (ws-lposn w)))) (posn-y (first (ws-lposn w)))) (ws-lposn w) false) 0 (+ 1 (ws-tick w)))]
        [(= (ws-dir w) 1) (make-ws (move-snake (make-posn (posn-x (first (ws-lposn w))) (+ (* 2 SEGRADIUS) (posn-y (first (ws-lposn w))))) (ws-lposn w) false) 1 (+ 1 (ws-tick w)))]
        [(= (ws-dir w) 2) (make-ws (move-snake (make-posn (- (posn-x (first (ws-lposn w))) (* 2 SEGRADIUS)) (posn-y (first (ws-lposn w)))) (ws-lposn w) false) 2 (+ 1 (ws-tick w)))]
        [(= (ws-dir w) 3) (make-ws (move-snake (make-posn (posn-x (first (ws-lposn w))) (- (posn-y (first (ws-lposn w))) (* 2 SEGRADIUS))) (ws-lposn w) false) 3 (+ 1 (ws-tick w)))])
        (cond
          [(= (ws-dir w) 0) (make-ws (move-snake (make-posn (+ (* 2 SEGRADIUS) (posn-x (first (ws-lposn w)))) (posn-y (first (ws-lposn w)))) (ws-lposn w) true) 0 (+ 1 (ws-tick w)))]
          [(= (ws-dir w) 1) (make-ws (move-snake (make-posn (posn-x (first (ws-lposn w))) (+ (* 2 SEGRADIUS) (posn-y (first (ws-lposn w))))) (ws-lposn w) true) 1 (+ 1 (ws-tick w)))]
          [(= (ws-dir w) 2) (make-ws (move-snake (make-posn (- (posn-x (first (ws-lposn w))) (* 2 SEGRADIUS)) (posn-y (first (ws-lposn w)))) (ws-lposn w) true) 2 (+ 1 (ws-tick w)))]
          [(= (ws-dir w) 3) (make-ws (move-snake (make-posn (posn-x (first (ws-lposn w))) (- (posn-y (first (ws-lposn w))) (* 2 SEGRADIUS))) (ws-lposn w) true) 3 (+ 1 (ws-tick w)))])))

;update-key
;pressing an arrow key directs the snake.
(check-expect (update-key (make-ws lposn 1 1) "left")
              (make-ws lposn 2 1))
(define (update-key w ke)
  (cond
    [(and (string=? ke "right") (not (= (ws-dir w) 2))) (make-ws (ws-lposn w) 0 (ws-tick w))] 
    [(and (string=? ke "down") (not (= (ws-dir w) 3))) (make-ws (ws-lposn w) 1 (ws-tick w))]
    [(and (string=? ke "left") (not (= (ws-dir w) 0))) (make-ws (ws-lposn w) 2 (ws-tick w))]
    [(and (string=? ke "up") (not (= (ws-dir w) 1))) (make-ws (ws-lposn w) 3 (ws-tick w))]
    [else w]))

;end?
;end if snakehead hits wall
(check-expect (end? (make-ws (list (make-posn 6 6)) 2 1)) false)
(check-expect (end? (make-ws (list (make-posn -4 6)) 2 1)) true)
(check-expect (end? (make-ws (list (make-posn 6 111116)) 1 1)) true)
(check-expect (end? (make-ws (list (make-posn 6 -6)) 2 1)) true)
(define (end? w)
  (or (< (posn-x (first (ws-lposn w))) 0)
      (< (posn-y (first (ws-lposn w))) 0)
      (> (posn-x (first (ws-lposn w))) SCNWDT)
      (> (posn-y (first (ws-lposn w))) SCNHGT)
      (bonks-self (ws-lposn w))))

;new-block
;ws -> ws
;retires "block" to the landscape and creates a new block
(check-expect

(define (main ws)
 (big-bang ws
  [on-tick update-tick]
  [on-key update-key]
  [to-draw render]
  [stop-when end?]))

(main (make-ws lposn 0 0))
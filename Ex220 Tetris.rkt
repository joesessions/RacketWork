;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Ex220 Tetris|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
(define HEIGHT 15)
(define WIDTH 10) ; # of blocks, horizontally 
(define SIZE 30) ; blocks are squares
(define SCNWDT (* WIDTH SIZE))
(define SCNHGT (* HEIGHT SIZE))


(define MTSCN (empty-scene SCNWDT SCNHGT))

(define BLOCK ; red squares with black rims
  (overlay
    (square (- SIZE 1) "solid" "red")
    (square SIZE "outline" "black")))

(define-struct tetris [block landscape rate score])
(define-struct block [x y])
 
; A Tetris is a structure:
;   (make-tetris Block Landscape)
; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)
; A Block is a structure:
;   (make-block N N)
 
; interpretations
; (make-block x y) depicts a block whose left 
; corner is (* x SIZE) pixels from the left and
; (* y SIZE) pixels from the top;
; (make-tetris b0 (list b1 b2 ...)) means b0 is the
; dropping block, while b1, b2, and ... are resting

(define landscape0 '())
(define block-dropping (make-block 50 10))
;(define tetris0 (make-tetris '() landscape0))
(define tetris0-drop (make-tetris block-dropping landscape0 2 0))

(define block-landed (make-block 50 (* SIZE (- HEIGHT 1))))

(define block-on-block (make-block 50 (* SIZE (- HEIGHT 2))))

(define block-on-block-landscape (list block-on-block block-landed))

(define tetris-3 (make-tetris block-dropping block-on-block-landscape 2 0))

(define tetris-hit-bottom (make-tetris (make-block 50 140) '() 2 0))
(define tetris-hit-block (make-tetris (make-block 50 130) (list (make-block 50 140)) 2 0))

;(check-expect (tetris-render tetris0)
 ;             MTSCN)
(check-expect (tetris-render tetris0-drop)
              (place-image BLOCK 50 10 MTSCN))
(check-expect (tetris-render tetris-3)
              (place-image BLOCK 50 10
               (place-image BLOCK 50 130
                 (place-image BLOCK 50 140
                   MTSCN))))

(define landscape (list (make-posn 50 130) (make-posn 50 140)))
              
(define (tetris-render ws)
  (cond
    [(empty? (tetris-landscape ws)) (place-image (text (number->string (tetris-score ws)) 24 "olive") 280 15 (place-image BLOCK (block-x (tetris-block ws)) (block-y (tetris-block ws)) MTSCN))]
    [else (place-image BLOCK
               (block-x (first (tetris-landscape ws)))
               (block-y (first (tetris-landscape ws)))
               (tetris-render (make-tetris (tetris-block ws) (rest (tetris-landscape ws)) (tetris-rate ws) (tetris-score ws))))]))

(define (main ws)
 (big-bang ws
  [on-tick update-tick (tetris-rate ws)]
  [on-key update-key]
  [to-draw tetris-render]
  [stop-when end?]))

; update-tick
; > ws -> ws
; every clock tick moves the block down
; unless it's touching the next block/ground in which case it makes a new block
; it will first check whether the block, with block-y+10, is a member of the blocks in the landscape or hits the ground
; if so, it will add that block to the landscape, create the new block (with new method) and return the ws;
(check-expect (update-tick (make-tetris (make-block 50 10) '() 2)) (make-tetris (make-block 50 20) '() 2 0))
(define (update-tick ws)
  (cond
    [(filled-row? (tetris-landscape ws)) (drop-landscape ws)]
    [(hit-something? ws) (new-block ws)]

    [else (move-down ws)]))

;drop-landscape
; ws-> ws
; takes the landscape, adds 10 to the y-value of each block, unless it's >= 145, in which case it will drop it.
(check-expect (drop-landscape (make-tetris (make-block 5 45) (list (make-block 5 145) (make-block 15 145) (make-block 25 145) (make-block 35 145) (make-block 45 145) (make-block 55 145) (make-block 65 145) (make-block 75 145) (make-block 85 145) (make-block 95 145))
                    2)) (make-tetris (make-block 5 45) '() 2 0))
(check-expect (drop-landscape (make-tetris (make-block 5 45) (list (make-block 5 135) (make-block 5 145) (make-block 15 145) (make-block 25 145) (make-block 35 145) (make-block 45 145) (make-block 55 145) (make-block 65 145) (make-block 75 145) (make-block 85 145) (make-block 95 145))
                    2)) (make-tetris (make-block 5 45) (list (make-block 5 145)) 2 0))
(define (drop-landscape ws)
  (make-tetris (tetris-block ws) (drop-landscape-2 (tetris-landscape ws)) (tetris-rate ws) (tetris-score ws)))

(define (drop-landscape-2 lsp)
  (cond
    [(empty? lsp) '()]
    [(not (= (block-y (first lsp)) 420))
          (cons
              (make-block (block-x (first lsp)) (+ (block-y (first lsp)) 30))
              (drop-landscape-2 (rest lsp)))]
     [else (drop-landscape-2 (rest lsp))]))

;filled-row?
; landscape -> bool
; takes the landscape, and determines if all the bottom-slots are filled.
(check-expect (filled-row? (list (make-block 15 420) (make-block 45 420) (make-block 75 420) (make-block 105 420) (make-block 135 420) (make-block 165 420) (make-block 195 420) (make-block 225 420) (make-block 255 420) (make-block 285 420))
                    ) true)
(check-expect (filled-row? (list (make-block 5 135) (make-block 15 140) (make-block 25 140) (make-block 35 140) (make-block 45 140) (make-block 55 140) (make-block 65 140) (make-block 75 140) (make-block 85 140) (make-block 95 140))
                    ) false)

(define (filled-row? lsp)
  (= (bottom-row-total lsp) 1500))

; bottom-row-total
; landscape -> total of x-values from all blocks on the y=145 row
(check-expect (bottom-row-total (list (make-block 15 420) (make-block 45 420) (make-block 75 420) (make-block 105 420) (make-block 135 420) (make-block 165 420) (make-block 195 420) (make-block 225 420) (make-block 255 420) (make-block 285 420))
                    ) 1500)
(define (bottom-row-total lsp)
  (cond
    [(empty? lsp) 0]
    [(= (block-y (first lsp)) 420) (+ (block-x (first lsp))
             (bottom-row-total (rest lsp)))]
    [else (bottom-row-total (rest lsp))]))
   
; move-down
; ws -> ws
; moves the block in ws down one block.
(check-expect (move-down (make-tetris (make-block 50 10) '() 2 0)) (make-tetris (make-block 50 20) '() 2 0)) 
(define (move-down ws)
  (make-tetris (make-block (block-x (tetris-block ws))  (+ 30 (block-y (tetris-block ws)))) (tetris-landscape ws) (tetris-rate ws) (tetris-score ws)))
(define (move-left ws)
  (make-tetris (make-block (- (block-x (tetris-block ws)) 30)  (block-y (tetris-block ws))) (tetris-landscape ws) (tetris-rate ws) (tetris-score ws)))
(define (move-right ws)
  (make-tetris (make-block (+ (block-x (tetris-block ws)) 30)  (block-y (tetris-block ws))) (tetris-landscape ws) (tetris-rate ws) (tetris-score ws)))

; hit-something?
; ws-> bool
; checks the tetris-block has a y-val less than 150 and against each member of the landscape
; return true if contact with anything
(check-expect (hit-something? tetris-hit-bottom) true)
(check-expect (hit-something? tetris-hit-block) true)
(check-expect (hit-something? tetris-3) false)

(define (hit-something? ws)
  (cond
    [(>= (block-y (tetris-block ws)) 420) true]
    [(empty? (tetris-landscape ws)) false]
    [(contact (tetris-block ws) (first (tetris-landscape ws))) true]
    [else (hit-something? (make-tetris (tetris-block ws) (rest (tetris-landscape ws)) (tetris-rate ws) (tetris-score ws)))]))

(define (hit-something-l? ws)
  (cond
    [(<= (block-x (tetris-block ws)) 15) true]
    [(empty? (tetris-landscape ws)) false]
    [(contactl (tetris-block ws) (first (tetris-landscape ws))) true]
    [else (hit-something-l? (make-tetris (tetris-block ws) (rest (tetris-landscape ws)) (tetris-rate ws) (tetris-score ws)))]))

(define (hit-something-r? ws)
  (cond
    [(>= (block-x (tetris-block ws)) 285) true]
    [(empty? (tetris-landscape ws)) false]
    [(contactr (tetris-block ws) (first (tetris-landscape ws))) true]
    [else (hit-something-r? (make-tetris (tetris-block ws) (rest (tetris-landscape ws)) (tetris-rate ws) (tetris-score ws)))]))
; contact
; block block -> bool
(define (contact tb bb)
  (and (= (block-x tb) (block-x bb)) (= (+ (block-y tb) 30) (block-y bb))))

(define (contactl b lb)
  (and (= (block-x b) (+ 30 (block-x lb))) (= (block-y b) (block-y lb))))
(check-expect (contactr (make-block 15 15) (make-block 25 15)) true)
(define (contactr b rb)
  (and (= (block-x b) (- (block-x rb) 30)) (= (block-y b) (block-y rb)))) 
            
            
; new-block
; ws-> ws
; moves block into landscape and makes a new block in a random place
;; (define tetris-hit-block (make-tetris (make-block 50 130) (list (make-block 50 140)) 2))
(check-random (new-block tetris-hit-block)
              (make-tetris (make-block (+ 5 (* SIZE (random 10))) 0) (list (make-block 50 130) (make-block 50 140)) 2 0))

(define (new-block ws)
     (make-tetris (make-block (+ 15 (* SIZE (random 10))) 0) (cons (tetris-block ws) (tetris-landscape ws)) (tetris-rate ws) (+ 1 (tetris-score ws))))

(define (end? ws)
  (cond
    [(empty? (tetris-landscape ws)) false]
    [else (< (block-y (first (tetris-landscape ws))) 60)]))

;update-key
; ws ->> ws
; if player presses left and there is nothing blocking this, move the block to the left. and for right
(define (update-key ws ke)
  (cond
    [(string=? ke "left")
     (cond
       [(hit-something-l? ws) ws]
       [else (move-left ws)])]
    [(string=? ke "right")
     (cond
       [(hit-something-r? ws) ws]
       [else (move-right ws)])]
    [else ws]))
      
       


(main (make-tetris (make-block 15 0) '() .02 0))
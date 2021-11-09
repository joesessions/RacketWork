;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX225 FireKiller.rkt~|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; What I should get out of programming it:
;  A next level of challenge and coordinating many different design elements, in attempts to bring into being my original intention.
;  building everything on a framework of design variables, so certain game parameters can be changed without breaking eg. 
; What I should not waste time on:
;  Revamping my first draft.
;  creeping the scope out to actually make a "pro game". Making 2 levels will teach me as much as 10. So make only 2 with t he first being stupid-simple.
;  such a big scope I don't actually complete it.
; Game play:
; plane will consist of a fat line with a block representing the vertical tailfin.
; will drop "water bombs" that start with velocity of plane, then accelerate downward till they hit the ground.
; player will fly over lakes, and can slam into lake with no problem. Plane will be righted and keep its speed. Hitting the ground will end the game.
; environment will be a loop, consisting of mountains, lakes and fires.
; plane can loop and go backwards, tail will stay on top, however stalls are also a possibility. Plane will stay in middle of screen, and world will move. 
;  (stall = plane immediately flicks from say 70 degrees upward to 70 degrees downward
; Player will control the pitch of the plane and throttle (zero, middle and full).

; each pixel will be a "foot" wide. 
; constant settings; drag (proportional to speed), thrust, gravity, dimensions of mtscn, water bomb capacity (refilled with each lake contact), water splash radius, starting score
; struct for the level: World: Mountains (vertical lines one foot wide) placement and height of each mountain, lakes: start and end position on world,
; fires: [location type] type 0 are "middle" and don't move. Type 1 progress left and leave 0's behind them. Type 2 progress right and leave 0's behind them.
; fires, if they hit a mountain jump to the other side of the mountain and continue. Water bomb nor water splash cannot pass through mountain. If water bomb passes under tip of
; mountain, (hits mountain) it vanishes.  Water splash ends at mountain and doesn't "extend further" on other side.
; When water hits fire, segment turns black, and cannot re-burn. Water covers a certain length of ground and remains for the rest of game (black if touched fire, blue if not).
; Neither can burn.
; start with x points, loose points for each pixel burned. Game over at contact with ground or 0 points or all fires out.
; screen will display speed, number of water bombs remaining (pictorally), percent fire coverage and score in upper corners.
; two blasts can fly at a time. Blasts, if they leave the screen, continue to carry out their life and splat some water.

; ws -world state
;(define-struct ws [lvl gspd tick planePos planeVel planeWater flyingBombs groundItems])
; [level gamespeed planePos planeVel planeWater groundItems]
; level -> int -> 1 or 2. After 2 is beat "end of game". Switch from level 1 to 2 populates all fields with the lvl2 environment.
; planePos is X Y of the aircraft. This will translate to x y in the MTSCN where x of the plane is always 700, and y = SCNHGT - Y.

; planeVel is speed of the aircraft in ft/s AND angle of flight, with straight left being theta=0 and up being theta=90, etc.
;(define-struct planeState [spd theta hgt])
; planeWater is an int from 1 to 5 (waterbombs on board)

; groundItems are a list of
; lakes (blue, type = 0, height GRASSHGT),
; mountains (purple, type = 1, height varies),
; fires (type = 2, height 2xGRASSHGT),
; burnt (Black, type = 3, height GRASSHGT),
; watered (lightblue  Type=4, height GRASSHGT)\

;(require racket/include)
;/(require "FireKillerMainAndUpdate.rkt")

(define (get-color i)
  (cond
    [(= i 0) "blue"]
    [(= i 1) "purple"]
    [(= i 2) "red"]
    [(= i 3) "black"]
    [(= i 4) "lightblue"]))
    
    
; the bottom row of the image starts with a fat stripe of green, which then can get covered up by the above colors,
;  if they start or end in the viewport. 
;(define-struct groundItem [X1 X2 type hgt])
; groundItems is either:
  ; '()
  ; (cons groundItem groundItems)
; a flying-bomb is a (X Y xspd yspd) It stars with the speed and position of the plane at deployment and just accelerates downward from there.
  ;upon hitting the ground it spreads out SPLATRADIUS in each direction, thereby making a new scene item and gobbling up any thing
  ;except a mountain. A function called splat will need to compute all the changes to the list of scene objects.
(define-struct flyingBomb [X Y xvel yvel])
; flyingBombs is either:
  ; '()
  ; (cons flyingBomb flyingBombs)
  ;   
; Render: get a loi (list of items) that fits in the screen. The environment will start at zero, going right to 14000 (10 ten screens
;  of width)
  ; function needed to cull a list of scene items within the current scene.
  ; in turn make a function that draws all the scene items into one image that starts on the origin.
  ; Draw the plane on the scene items on the green stripe on the game data (score etc) on the MTSCN
; keys: R full throttle, f half-throttle, v no throttle, space drop water bomb. Left/ right rotate the plane.  
; On-tick: the x-speed of the plane will equal the offset shift.
  ; The plane will simply fly straight. There will be no calc for lift v weight. There will be a weight consideration for
  ; rising and falling acceleration, however. The plane will weigh KG, and the full thrust FTHROTTLE will be a fraction of that
  ; half-thrust HTHROTTLE will be a smaller fraction. (I'm thinking KG/3 and KG/6)
  ; each tick a calc is made for the physics of it determine the new speed and position. It also checks for a stall condition.
  ; (stall, under a certain speed(STALLSPEED), the angle suddenly flips down. To either the opposite of its angle (45 deg up becomes
  ; 45 deg down) or 30deg down, whichever is lower.
  ; Also, calcs will need to be done for bombs.
  ; Also, the fire will spread every so many ticks. use a modulo. 
; will also need to calc if all fire is out, and if so, move to level 2 
;wishlist
;function that takes groundItem-type and returns color
;movetolevel 2, totally updates the ws with the next level.
;drawData
;drawScore
;drawSpeed - score is green if fast. Yellow approaching stall speed, Red almost stall.
;drawbombs

(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)
;
(define GAMESPEED 2)
(define SCNHGT 800)
(define SCNWDT 1400)
(define ENVIRONWDT 5000)
(define MTSCN (empty-scene SCNWDT SCNHGT))
(define GRASSHGT 10)
(define FIREHGT (* 2 GRASSHGT))
(define-struct ws [lvl gspd tick x planeState planeWater flyingBombs groundItems])
(define-struct groundItem [X1 X2 type hgt])
(define-struct planeState [spd theta hgt thr])

; PLANE BEHAVIOR VARIABLES
(define G .7)
(define DRAG .07)
(define PLANEWGT 2)
(define BOMBWGT .4)
(define HALFTHR .5)
(define FULLTHR 1.4)
(define STALLSPD 4)
(define FIRESPD 25) ; lower number is faster
(define BOUNCEPLANESTATE (make-planeState 20 2 15 FULLTHR));[spd theta hgt thr] )

;WORLDSTATE VARIABLES
(define planeState0 [make-planeState 10 0 (/ SCNHGT 2) FULLTHR])
(define lake01 [make-groundItem 1600 1750 0 GRASSHGT])
(define lake02 [make-groundItem 4100 4150 0 GRASSHGT])
(define mountain01 [make-groundItem 3500 3502 1 300]) 
;(define mountain02 [make-groundItem 10000 10002 1 200])
(define fire0 [make-groundItem 1000 1010 2 FIREHGT])
(define firetest2 [make-groundItem 1100 1110 2 FIREHGT])
(define firetestend [make-groundItem 1200 1210 2 FIREHGT])
(define tinyMtn [make-groundItem 200 200 1 GRASSHGT])
;(define fire1 [make-groundItem 7000 7010 2 FIREHGT])
(define fire2 [make-groundItem 3000 3010 2 FIREHGT])
(define fire3 [make-groundItem 4000 4010 2 FIREHGT])
;(define fire4 [make-groundItem 12000 12010 2 FIREHGT])
(define groundItems0 (list lake01 lake02 mountain01 fire0 fire2))  
(define ws0 [make-ws 1 1 10000 0 planeState0 25 '() groundItems0])
(define groundItems2 (list lake01 lake02 mountain01 fire0 fire2 fire3))  
(define ws2 [make-ws 2 1 10000 0 planeState0 25 '() groundItems2])

(define groundItemsEND (list lake01 lake02 mountain01 fire0)); fire1 fire2 fire3 fire4))
(define wsEND [make-ws 3 100 10000 0 planeState0 5 '() groundItemsEND])

(check-expect (give-next-level 2 LEVELS 3000)
              ws2)

(define LEVELS (list ws0 ws2))

;give-next-level
; num wss score -> ws
; given a number, give that item in the sequence 
(define (give-next-level num wss score)
  (cond
    [(= 3 num) (make-ws (ws-lvl wsEND) (ws-gspd wsEND) score
                        (ws-x wsEND) (ws-planeState wsEND) (ws-planeWater wsEND)
                        '() (ws-groundItems wsEND))]
    [(= 0 num) "shouldn't happen"]
    [(= 1 num) (make-ws (ws-lvl (first wss)) (ws-gspd (first wss)) score
                        (ws-x (first wss)) (ws-planeState (first wss)) (ws-planeWater (first wss))
                        '() (ws-groundItems (first wss)))]
    [else (give-next-level (- num 1) (rest wss) score)]))

;score -> image
(define (you-win score)
  (overlay (text (string-append "You win!!!!   Score:  " (number->string score)) 70 "red") (empty-scene 1400 500)))
;(define (render ws)
 ; (
; Render: get a loi (list of items) that fits in the screen. The environment will start at zero, going right to 14000 (10 ten screens
;  of width)
  ; function needed to cull a list of scene items within the current scene.
  ; in turn make a function that draws all the scene items into one image that starts on the origin.
  ; Draw the plane on the scene items on the green stripe on the game data (score etc) on the MTSCN


; get-visibles
; ground-items x  -> grounditems
; if an item has an X1 or X2 position within SCNWDT/2 of x, include in the list.
; (define groundItems2 (cons (make-groundItem 100 160 0 GRASSHGT) groundItems1))
(define groundItems3 (cons (make-groundItem 0 1 1 (/ SCNHGT 2)) groundItems2))
(check-expect (get-visibles? groundItems0 0) '())
(check-expect (get-visibles? (cons (make-groundItem 200 200 1 GRASSHGT) groundItems0) 0)
              (list (make-groundItem 200 200 1 GRASSHGT)))

(define (get-visibles? logi x)
  (cond
    [(empty? logi) '()]
    [(is-visible? (first logi) x) (cons (first logi) (get-visibles? (rest logi) x))]
    [else (get-visibles? (rest logi) x)]))

; is-visible
 ; ground-item -> bool
(check-expect (is-visible fire0 0) false)
(check-expect (is-visible tinyMtn 0) true)
(define (is-visible? gi x)
  (or (< (abs (- (groundItem-X2 gi) x)) (/ SCNWDT 2)) (< (abs (- (groundItem-X1 gi) x)) (/ SCNWDT 2))))


(define PLANE (overlay/offset (rotate 25 (isosceles-triangle 20 40 "solid" "black")) 12
                  7 (ellipse 40 10 "solid" "black")))
(define PLANE2 (overlay/offset (rotate -25 (isosceles-triangle 20 40 "solid" "black")) -12
                  7 (ellipse 40 10 "solid" "black")))

;water-bomb-display
;number -> image
;Given the number of water bombs, they are each displayed as a square with the next added below.
(define (water-bomb-display bombs)
  (cond
    [(= bombs 0) (empty-scene 1 1)]
    [(= bombs 1) (circle 5 "solid" "lightblue")]
    [else (above (circle 5 "solid" "lightblue") (water-bomb-display (- bombs 1)))]))



;lowest-X1
;gis -> x
; looks through visibles, returns the lowest X1 values.
(define (offset gis x)
  (cond
    [(empty? gis) 0]
    [else (max (- x (/ SCNWDT 2) (groundItem-X1 (first gis))) (offset (rest gis) x))]))

; render-datascreen
; ws -> image
; takes the ticks (aka score) planeWater, planeState-spd, x and draws it all on the MTSCN
;(overlay/xy i1 x y i2)
;(text "Hello" 24 "olive")
(define (render-datascreen w) 
  (overlay/xy (water-bomb-display (ws-planeWater w)) -20 -60
  (overlay/xy (text (number->string (planeState-spd (ws-planeState w))) 60 "black") (- 100 SCNWDT) -30
  (overlay/xy (text (string-append "Position:  " (number->string (round (ws-x w)))) 24 "black") -300 -20 
  (overlay/xy (text (string-append "Score:  " (number->string (ws-tick w))) 24 "black") -20 -20 MTSCN))))) 

;(render-datascreen ws0)

; render-landscape
; ws -> image
; generates an image to be laid over the grass at the bottom of the screen.
; 
(define (render-landscape w)
  (render-visibles (get-visibles? (ws-groundItems w) (ws-x w)) (ws-x w)))
; render-visibles
; logi -> image
(define (render-visibles logi x)
  (cond
    [(empty? logi) (rectangle (- SCNWDT 2) GRASSHGT "solid" "green")] ;-1 (- GRASSHGT SCNHGT -1)]
    [else (overlay/align/offset "left" "bottom"
               (rectangle (max 0 (- (groundItem-X2 (first logi)) (X1-cropper x (groundItem-X1 (first logi))))) (groundItem-hgt (first logi))  "solid" (get-color (groundItem-type (first logi))))
                    (- x (+ (/ SCNWDT 2) (X1-cropper x (groundItem-X1 (first logi))))) 0
                   (render-visibles (rest logi) x))])) 
  ;  (+ SCNWDT (offset (get-visibles? (ws-groundItems w) (ws-x w)) (ws-x w))) SCNHGT 

(define (X1-cropper x gix)
  (cond
    [(< gix (- x (/ SCNWDT 2))) (- x (/ SCNWDT 2))]
    [else gix]))
   

(define ws3 [make-ws 1 1 10000 0 planeState0 5 '() groundItems3])
(define ws4 [make-ws 1 1 10000 4000 planeState0 5 '() groundItems3])
(define wsReal [make-ws 1 40 10000 0 planeState0 25 '() groundItems0])
;(render-landscape ws3)

(define (render w)
  (cond
    [(= (ws-gspd w) 100) (you-win (ws-tick w))]
    [else (overlay/align/offset "left" "bottom"
                        (render-bombs (ws-flyingBombs w) (ws-x w)) 0 0 
  (overlay/align/offset "left" "bottom"
                        (rotate (deg (planeState-theta (ws-planeState w))) PLANE) (/ SCNWDT -2) (planeState-hgt (ws-planeState w))
  (overlay/align/offset "left" "bottom"
       (render-landscape w) -1 1
       (render-datascreen w))))]))
;(render ws3)

(define (deg theta)
  (* (/ theta 40) 360))
 
; x planeState -> x
(define (next-pos x ps)
  (next-pos2 x (* (cos (rad (planeState-theta ps))) (planeState-spd ps))))


;next-pos2 handles the moving and looping problem
; x gspd -> x
(check-expect (next-pos2 13995 10) 5)

(check-expect (next-pos2 13996 10) 6)
(check-expect (next-pos2 5 -10) 13995)

(define (next-pos2 x gspd)
  (cond
    [(> (+ x gspd) ENVIRONWDT) (+ gspd (- x ENVIRONWDT))]
    [(< (+ x gspd) 0) (+ gspd x ENVIRONWDT)]
    [else (+ x gspd)]))

; plane speed = simplified F=ma.  The net force, considered longitutinally, divided by the weight (weight = 5 + #bombs) = a
; Force = gravity component, thrust, and drag (spd*CD)

; lonj-force
; angle (0-39), throttle, speed (planeState) -> Force

(define (lonj-force ps pw)
   (+ (* -1 G (+ PLANEWGT (* BOMBWGT pw)) (sin (rad (planeState-theta ps)))) (* -1 DRAG (planeState-spd ps) (+ 1 (/ pw 10))) (planeState-thr ps)))  

(define (rad num)
  (* num (/ pi 20)))
; new-speed 
; planeState-spd lonj-force planeWater (ws) -> planeState-speed
(define (new-spd ps pw)
 (+ (planeState-spd ps) (/ (lonj-force ps pw) (+ PLANEWGT (* BOMBWGT pw)))))

;new-hgt
; planeState -> planeState-hgt
(define (new-hgt ps)
 (cond
   [(> (hgt-calc ps) SCNHGT) SCNHGT]
   [else (hgt-calc ps)]))


(define (hgt-calc ps)
  (+ (planeState-hgt ps) (* (sin (rad (planeState-theta ps))) (planeState-spd ps))))
; new-theta
; planeState -> planeState-theta
; if speed is ever below STALLSPEED and above 0 theta, change theta

(define (new-theta ps)
  (cond
    [(< (planeState-spd ps) STALLSPD) 
          (cond
             [(< (planeState-theta ps) 4) 37 ]
             [(< (planeState-theta ps) 16) (- 40 (planeState-theta ps))]
             [(< (planeState-theta ps) 23) 23]
             [(< (planeState-theta ps) 37) (planeState-theta ps)]
             [else 37])]
    [else (planeState-theta ps)]))


; next-planeState
; separate functions new-speed and new-height will be called by this. Throttle changed by key-update.
;(define-struct planeState [spd theta hgt thr])
(define (next-planeState ps pw)
  (make-planeState (new-spd ps pw) (new-theta ps) (new-hgt ps) (planeState-thr ps)))

;(define-struct ws [lvl gspd tick x planeState planeWater flyingBombs groundItems])

; angle is in 40ths of a circle. pi/20.
;
;rudimentary

;(define (update-tick w)
;  (make-ws (ws-lvl w) (ws-gspd w) (- (ws-tick w) 1) (next-pos (ws-x w) (ws-planeState w)) (next-planeState (ws-planeState w) (ws-planeWater w))
;           (ws-planeWater w) (ws-flyingBombs w) (ws-groundItems w)))

;next-groundItems
; w gis -> gis
; grows fires (checks if they hit a puddle, mtn or lake and stops if so)
; checks if a waterbomb hit and if so makes a splat which overtakes fires and leaves a puddle.
;;(define-struct groundItem [X1 X2 type hgt])  0 lake, 1 mtn, 2 fire, 4 puddle)
;fires grow on even numbers, but if end points are odd, they dont)

(define (next-groundState w gis)
  (cond
    [(empty? gis) '()]
    [(any-bomb-hit-ground? (ws-flyingBombs w)) (splat (where-bomb-hit-ground (ws-flyingBombs w)) gis gis)]
    [(= (modulo (ws-tick w) FIRESPD) 0) (grow-fire gis gis)]
    [else gis]))

(define SPLATRAD 50)
;splat
;x gis gisO -> gis
;if splat is entirely in fire, does nothing.returns original gis. 
;recurses through the gis. at empty list, adds new gi for the puddle.
;for each gi, covers-entirely? -> don't add it back to the list.
;covers X1 -> alter X1 to be +1 from top end of splat
;covers X2 -> alter X2 to be -1 from bottom end of splat
(define (splat x gis gisO)
  (cond
    [(bomb-engulfed? x gis) gis]
    [else (splat-recurse x gis gisO)]))

(define (splat-recurse x gis gisO)
         (cond
            [(empty? gis) (cons (make-groundItem (- x SPLATRAD) (+ x SPLATRAD) 4 GRASSHGT) '())]
            [(and (is-fire? (first gis)) (covers-X1? x (first gis)) (covers-X2? x (first gis))) (splat-recurse x (rest gis) gisO)]
            [(and (is-fire? (first gis)) (covers-X1? x (first gis)))
             (cons (make-groundItem (+ x SPLATRAD 1) (groundItem-X2 (first gis)) 2 FIREHGT) (splat-recurse x (rest gis) gisO))]
            [(and (is-fire? (first gis)) (covers-X2? x (first gis)))
             (cons (make-groundItem (groundItem-X1 (first gis)) (- x 1 SPLATRAD) 2 FIREHGT) (splat-recurse x (rest gis) gisO))]
            [else (cons (first gis) (splat-recurse x (rest gis) gisO))]))
            

(define (covers-X1? x gi)
  (and (< (- x SPLATRAD) (groundItem-X1 gi)) (> (+ x SPLATRAD) (groundItem-X1 gi))))

(define (covers-X2? x gi)
  (and (< (- x SPLATRAD) (groundItem-X2 gi)) (> (+ x SPLATRAD) (groundItem-X2 gi))))

              
(define (bomb-engulfed? x gis)
  (cond
    [(empty? gis) false]
    [(and (< (groundItem-X1 (first gis)) (- x SPLATRAD)) (> (groundItem-X2 (first gis)) (+ x SPLATRAD))) true]
    [else (bomb-engulfed? x (rest gis))]))


;where-bomb-hit-ground
;waterbombs -> x
;returns the x-value of the bomb which hit ground (hgt<1)
(define (where-bomb-hit-ground wbs)
  (cond
    [(empty? wbs) 0]
    [(< (flyingBomb-Y (first wbs)) 1) (round (* 2 (round (/ (flyingBomb-X (first wbs)) 2))))]
    [else (where-bomb-hit-ground (rest wbs))]))

;grow-fire
;ws gis -> gis
;spreads out the fire as appropriate to logic
(define (grow-fire gis gisO)
  (cond
    [(empty? gis) '()]
    [(is-fire? (first gis)) (cons (make-groundItem (next-fire-X1 (groundItem-X1 (first gis)) gisO)
                                                   (next-fire-X2 (groundItem-X2 (first gis)) gisO) 2 FIREHGT) (grow-fire (rest gis) gisO))]
    [else (cons (first gis) (grow-fire (rest gis) gisO))]))
     
(define (is-fire? gi)
    (= (groundItem-type gi) 2))

; X1 gis -> X1 for fire.  Grows down if even and doesn't hit another ground-item
(define (next-fire-X1 x1 gis)
  (cond
    [(not (= 0 (modulo x1 2))) x1] 
    [(something-down? x1 gis) (- x1 1)]
    [else (- x1 2)]))
                              
;something-down?
;X1 gis -> bool
;returns true if there is another object's X2 exactly 2 less
(define (something-down? x1 gis)
  (cond
    [(empty? gis) false]
    [(= (- x1 2) (groundItem-X2 (first gis))) true]
    [else (something-down? x1 (rest gis))]))

; X2 gis -> X2 for fire.  Grows up if even and doesn't hit another ground-item
(define (next-fire-X2 x2 gis)
  (cond
    [(not (= 0 (modulo x2 2))) x2] 
    [(something-up? x2 gis) (+ x2 1)]
    [else (+ x2 2)]))
                              
;something-up?
;X2 gis -> bool
;returns true if there is another object's X1 exactly 2 greater
(define (something-up? x2 gis)
  (cond
    [(empty? gis) false]
    [(= (+ x2 2) (groundItem-X1 (first gis))) true]
    [else (something-up? x2 (rest gis))]))

(define (update-tick w)
  (cond
    [(= (ws-gspd w) 100) w]
    [(not (fire-exists? (ws-groundItems w)))
        (give-next-level (+ 1 (ws-lvl w)) LEVELS (ws-tick w))]
    [(hit-lake? (ws-x w) (planeState-hgt (ws-planeState w)) (ws-groundItems w))
        (make-ws (ws-lvl w)
           (ws-gspd w)
           (- (ws-tick w) 1)
           (ws-x w) 
           BOUNCEPLANESTATE
           25
           (move-bombs (ws-flyingBombs w) w)
           (next-groundState w (ws-groundItems w)))]     
        [else
         (make-ws (ws-lvl w)
           (ws-gspd w)
           (- (ws-tick w) 1)
           (next-pos (ws-x w) (ws-planeState w))
           (next-planeState (ws-planeState w) (ws-planeWater w))
           (ws-planeWater w)
           (move-bombs (ws-flyingBombs w) w)
           (next-groundState w (ws-groundItems w)))]))



;hit-lake?
;x y gis  -> boolean (true/false)
(define (hit-lake? x y gis)
  (cond
    [(> y 12) false]
    [(is-lake-there? x gis) true]
    [else false]))
    
;is-lake-there?
;x gis
(define (is-lake-there? x gis)
  (cond
    [(empty? gis) false]
    [(on-a-lake? x (first gis)) true]
    [else (is-lake-there? x (rest gis))]))

;on-a-lake
;x gi -> bool
(define (on-a-lake? x gi)
  (cond
    [(not (is-a-lake? gi)) false]
    [(and (< (groundItem-X1 gi) x) (> (groundItem-X2 gi) x)) true]
    [else false]))
     
;is-a-lake?
; gi -> bool (true or false)
(define (is-a-lake? gi)
  (= 0 (groundItem-type gi)))

     
(define (update-key w ke)  
  (cond
    [(string=? ke "left")
          (make-ws (ws-lvl w) (ws-gspd w) (ws-tick w) (ws-x w) (change-theta (ws-planeState w) 1)
           (ws-planeWater w) (ws-flyingBombs w) (ws-groundItems w))] 
         [(string=? ke "right")
          (make-ws (ws-lvl w) (ws-gspd w) (ws-tick w) (ws-x w) (change-theta (ws-planeState w) -1)
           (ws-planeWater w) (ws-flyingBombs w) (ws-groundItems w))]
         [(or (string=? ke "r") (string=? ke "R"))
          (make-ws (ws-lvl w) (ws-gspd w) (ws-tick w) (ws-x w) (change-thrR (ws-planeState w))
           (ws-planeWater w) (ws-flyingBombs w) (ws-groundItems w))]
         [(or (string=? ke "f") (string=? ke "F"))
          (make-ws (ws-lvl w) (ws-gspd w) (ws-tick w) (ws-x w) (change-thrF (ws-planeState w))
           (ws-planeWater w) (ws-flyingBombs w) (ws-groundItems w))]
         [(or (string=? ke "v") (string=? ke "V"))
          (make-ws (ws-lvl w) (ws-gspd w) (ws-tick w) (ws-x w) (change-thrV (ws-planeState w))
           (ws-planeWater w) (ws-flyingBombs w) (ws-groundItems w))] 
         [(and (string=? ke " ") (> (ws-planeWater w) 0))
          (make-ws (ws-lvl w) (ws-gspd w) (ws-tick w) (ws-x w) (ws-planeState w)
          (new-planewater-drop (ws-planeWater w)) (create-bomb w) (ws-groundItems w))]
         
         [else w]
          ))

(define (new-planewater-drop nb)
  (- nb 1))

;change-thrR
(define (change-thrR ps)
  (make-planeState (planeState-spd ps) (planeState-theta ps) (planeState-hgt ps) FULLTHR))
;change-thrF
(define (change-thrF ps)
  (make-planeState (planeState-spd ps) (planeState-theta ps) (planeState-hgt ps) HALFTHR))
;change-thrV
(define (change-thrV ps)
  (make-planeState (planeState-spd ps) (planeState-theta ps) (planeState-hgt ps) 0))

;when space is pressed, if there is a bomb (planeWater > 0), create a bomb object in the same place and the same velocity as the plane. 
;each tick, check that the bomb doesn't hit a mountain or the ground.
;
;make a "hits mountain" method
;move bomb method 
;splat method (tomorrow)
;



;create bomb
; ws -> flyingBombs  (X Y xvel yvel)
; either starts the list or adds to the list of flyingBombs
(define (create-bomb w)
   (cons (make-flyingBomb (ws-x w) (planeState-hgt (ws-planeState w))
                          (* (cos (rad (planeState-theta (ws-planeState w)))) (planeState-spd (ws-planeState w)))
                          (* (sin (rad (planeState-theta (ws-planeState w)))) (planeState-spd (ws-planeState w)))) (ws-flyingBombs w)))

(define flyingBombs1 (cons (make-flyingBomb 10 10 3 3) (cons (make-flyingBomb 20 20 6 6) '())))

  ;fb -> bool
  ;determines (for now) if a bomb hit the ground.
(define (bomb-hit-ground? fb)
  (< (flyingBomb-Y fb) 1))

;any-bomb-hit-ground?
;lob -> bool
;true if any of the bombs hit the ground
(define (any-bomb-hit-ground? lob)
  (cond
    [(empty? lob) false]
    [(< (flyingBomb-Y (first lob)) 1) true]
    [else (any-bomb-hit-ground? (rest lob))]))  

;move-bombs
;flying-bombs -> flying-bombs
(check-expect (move-bombs flyingBombs1)
              (cons (make-flyingBomb 13 13 3 (- 3 (/ G 5))) (cons (make-flyingBomb 26 26 6(- 6 (/ G 5))) '())))
(define (move-bombs fb w)
  (cond
    [(empty? fb) '()]
    [(bomb-hit-ground? (first fb)) (move-bombs (rest fb) w)]
    [(bomb-hit-mtn? (first fb) (ws-groundItems w)) (move-bombs (rest fb) w)]
    [else 
     (cons (make-flyingBomb (+ (flyingBomb-X (first fb)) (flyingBomb-xvel (first fb)))
                            (+ (flyingBomb-Y (first fb)) (flyingBomb-yvel (first fb)))
                            (flyingBomb-xvel (first fb)) (- (flyingBomb-yvel (first fb)) (/ G 5)))
                (move-bombs (rest fb) w))]))

;bomb-hit-mtn?
;b groundItems   (define-struct flyingBomb [X Y xvel yvel])
;checks a bomb against the list of mtns to see if it's within 10px and under the hgt.
(define (bomb-hit-mtn? fb gis)
  (thing-hit-mtn? (flyingBomb-X fb) (flyingBomb-Y fb) gis))

(define (thing-hit-mtn? x y gis)
    (cond
    [(empty? gis) false]
    [(and (is-mountain? (first gis)) (hit-mountain? x y (first gis))) true]
    [else (thing-hit-mtn? x y (rest gis))]))
      
(define (is-mountain? gi)
  (= (groundItem-type gi) 1))

(define (hit-mountain? x y mtn)
  (and (within-ten? x (groundItem-X1 mtn))
       (< y (groundItem-hgt mtn))))

(define (within-ten? a b)
  (< (abs (- a b)) 10))


(define (plane-hit-mtn? w)
        (thing-hit-mtn? (ws-x w) (planeState-hgt (ws-planeState w)) (ws-groundItems w)))

;render-bombs
;lob -> image
(define (render-bombs fb x)
  (cond
    [(empty? fb) (empty-scene 0 0)]
    [else (overlay/align/offset "left" "bottom"
          (circle 5 "solid" "lightblue")
          (- (- (+ (/ SCNWDT 2) (flyingBomb-X (first fb))) x))
          (flyingBomb-Y (first fb))
          (render-bombs (rest fb) x))]))

;change-theta
;planeState -> planeState  (with theta changed)
(define (change-theta ps inc) 
  (make-planeState (planeState-spd ps) (change-theta-only (planeState-theta ps) inc) (planeState-hgt ps) (planeState-thr ps)))

(define (change-theta-only theta inc)
  (cond
    [(> (+ theta inc) 40) (+ theta inc -40)]
    [(< (+ theta inc)  0) (+ theta inc  40)]
    [else (+ theta inc)]))

(define (main ws)
 (big-bang ws
  [on-tick update-tick]
  [on-key update-key]
  [to-draw render]
  [stop-when end?]
   ))

;define is-fire
;groundItems -> bool
(define (fire-exists? gis)
  (cond
    [(empty? gis) false]
    [(is-fire? (first gis)) true]
    [else (fire-exists? (rest gis))]))

(define (end? w)
  (or (= 0 (ws-tick w))
      (< (planeState-hgt (ws-planeState w)) 1)
      (plane-hit-mtn? w)
      ))
(main wsReal)

  

;For the win
;Fire-growth repair
;plane-hits-mountain logic within end
;
;splat logic creates puddle at point of contact of bomb, overwrites fire, doesn't stop at mt. 
; refuel logic give 25 bombs
;next level when zero fires
;Make next level
;Game won when zero fires on 2nd level

;levels = list of worldstates;  Call next worldstate when fires= zero. if no more levels, end.

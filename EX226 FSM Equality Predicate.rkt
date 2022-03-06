;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |EX226 FSM Equality Predicate|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;EX 226 and 227

(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define-struct transition [current next])

(define fsm-traffic
         (list (make-transition "red" "green")
               (make-transition "green" "yellow")
               (make-transition "yellow" "red")))

;state=?
;determines if a state is one of a list of states
(define (isOneOfState? st ls)
  (cond
    [(empty? ls) false]
    [(state=? (first ls) st) true]
    [else (isOneOfState? st (rest ls))]))

(define (state=? s1 s2)
  (and (string=? (transition-current s1) (transition-current s2))
          (string=? (transition-next s1) (transition-next s2))))

(isOneOfState? (make-transition "red" "green") fsm-traffic)

(isOneOfState? (make-transition "red" "red") fsm-traffic)


;BW Machine

;    Black    --->  keystroke    ---|
;     ^                             |
;     |                             |
;     |                             v
;     L------  keystroke  <---   White

(define fsm-bw
  (list (make-transition "black" "white")
        (make-transition "white" "black")))

;FSM -> ???
; match the keys pressed with the given FSM
;(define (simulate an-fsm)
;  (big bang ...
;       [to-draw ...]
;       [on-key ...]))

; A simulationStat.v1 is an FSM-State
;(define (simulate.v1 fsm0)
;  (big-bang initial-state
;    [to-draw render-state.v1]
;    [on-key find-next-state.v1]))

; SimulationState.v1 -> Image
; renders a world state as an image
(define (render-state.v1 s)
  empty-image)

;SimulationState.v1 KeyEvent -> SimulationState.v1
; finds the next state from ke and cs
(define (find-next-state.v1 cs ke)
  cs)

(define-struct fs [fsm current])
; A SimulationState.v2 is a structure:
;  (make-fs (FSM FSM-State))

; SimulationState.v2 -> image
;renders a world state as an image
 (define (render-state.v2 s)
   empty-image)

; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from ke and cs
 (define (find-next-state.v2 cs ke)
   cs)

; FSM -> FSM-State -> SimulationState.v2
; match the keys pressed with the given FSM
 (define (simulate.v2 an-fsm s0)
   (big-bang (make-fs an-fsm s0)
     [to-draw state-as-colored-square]
     [on-key find-next-state]))

; SimulationState.v2 -> Image
(check-expect (state-as-colored-square
                 (make-fs fsm-traffic "red"))
                 (square 100 "solid" "red"))

(define (state-as-colored-square an-fsm)
  (square 100 "solid" (fs-current an-fsm)))

; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from an-fsm and ke
(define (find-next-state an-fsm ke)
  (cond
    [(string=? ke "r") (make-fs (fs-fsm an-fsm) (transition-current (first (fs-fsm an-fsm))))]
    [else 
     (make-fs  (fs-fsm an-fsm)
            (find (fs-fsm an-fsm) (fs-current an-fsm)))]))


; FSM FSM-State -> FSM-State
; finds the state representing current in transitions
; and retrieves the next field
(check-expect (find fsm-traffic "red") "green")
(check-expect (find fsm-traffic "green") "yellow")
(check-error (find fsm-traffic "black") "not-found: black")

(define (find an-fsm s)
  (cond
    [(empty? an-fsm) (error "not-found: " s)]
    [(string=? (transition-current (first an-fsm)) s) (transition-next (first an-fsm))] 
    [else (find (rest an-fsm) s)]))
(check-expect
 (find-next-state (make-fs fsm-traffic "red") "n")
 (make-fs fsm-traffic "green"))
(check-expect
 (find-next-state (make-fs fsm-traffic "red") "a")
 (make-fs fsm-traffic "green"))
(check-expect
 (find-next-state (make-fs fsm-traffic "green") "q")
 (make-fs fsm-traffic "yellow"))






;(simulate.v2 fsm-traffic "red")

(simulate.v2 fsm-bw "white")
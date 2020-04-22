;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname EX199) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;the 2htdp/itunes library documentation, part 1: 
 
; An LTracks is one of:
; – '()
; – (cons Track LTracks)
 
(define-struct track
  [name artist album time track# added play# played])
; A Track is a structure:
;   (make-track String String String N N Date N Date)
; interpretation An instance records in order: the track's 
; title, its producing artist, to which album it belongs, 
; its playing time in milliseconds, its position within the 
; album, the date it was added, how often it has been 
; played, and the date when it was last played

(define-struct date [year month day hour minute second])
; A Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (between 1 and 12 inclusive), 
; day (between 1 and 31), hour (between 0 
; and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).

;time is 4 ints: h min s ms, which add up to an expression of time in human-readable form.
(define-struct time [h min s ms])


(define date1 (make-date 1991 8 20 0 0 0))
(define date1.1 (make-date 2020 6 14 3 2 1))
(define pumpkins1 (make-track "Crush" "Smashing Pumpkins" "Gish" 1548000 4 date1 200 date1.1)) 

(define date2 (make-date 1985 2 2 0 0 0))
(define date2.1 (make-date 2018 3 4 0 0 0))
(define U21 (make-track "Where the Streets Have No Name" "U2" "The Joshua Tree" 39487534 0 date2 78 date2.1))

(define date3 (make-date 1979 4 4 0 0 0))
(define date3.1 (make-date 2007 5 5 0 0 0))
(define LedZep1 (make-track "Wearing and Tearing" "Led Zeppelin" "Coda" 9347245 5 date3 5 date3.1))

(define LTracks (list pumpkins1 U21 LedZep1))

;total-time
;Ltracks => hh:mm:ss.00
(check-expect (total-time LTracks) "00:20:23.343")
(check-expect (total-time '()) "00:00:00.000")
(define (total-time lt)
  (ms>display (time-adder lt)))
(define (time-adder lt)
  (cond
    [(empty? lt) 0]
    [else (+ (track-time (first lt)) (time-adder (rest lt)))]))

;ms>display
;ms > Human-readable string
(check-expect (ms>display 123) "00:00:00.123")
(check-expect (ms>display 3600000) "01:00:00.000")
(define (ms>display ms)
  (string-append (n>s 2 (time-h (ms>time ms))) ":"
                 (n>s 2 (time-min (ms>time ms))) ":"
                 (n>s 2 (time-s (ms>time ms))) "."
                 (n>s 3 (time-ms (ms>time ms)))))
;n>s
; num num > s
; first number is the number of desired digits, second is the number.
(check-expect (n>s 2 1) "01")
(check-expect (n>s 3 1) "001")
(check-expect (n>s 3 123) "123")
(check-expect (n>s 2 12) "12")
(check-expect (n>s 10 1) "0000000001")
(define (n>s len arg)
  (cond
    [(= (string-length (number->string arg)) len)
        (number->string arg)]
    [else (string-append "0" (n>s (- len 1) arg))]))

;ms->time
;int-> string
(check-expect (ms>time 123) (make-time 00 00 00 123))
(check-expect (ms>time 12345) (make-time 00 00 12 345))
(check-expect (ms>time 70000) (make-time 00 01 10 000))
(check-expect (ms>time 3600000) (make-time 01 00 00 000))
(define (ms>time ms)
  (make-time
   (/ (- (modulo ms 216000000) (modulo ms 3600000)) 3600000)
   (/ (- (modulo ms 3600000) (modulo ms 60000)) 60000)
   (/ (- (modulo ms 60000) (modulo ms 1000)) 1000)
   (modulo ms 1000)))
   

; Any Any Any Any Any Any Any Any -> Track or #false
; creates an instance of Track for legitimate inputs
; otherwise it produces #false
;(define (create-track name artist album time
 ;                     track# added play# played)
  ;...)
 
; Any Any Any Any Any Any -> Date or #false
; creates an instance of Date for legitimate inputs 
; otherwise it produces #false
;(define (create-date y mo day h m s)
 ; ...)
 
; String -> LTracks
; creates a list-of-tracks representation from the
; text in file-name (an XML export from iTunes)
;(define (read-itunes-as-tracks file-name)
 ; ...)
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

(define pumpkins1 (make-track "Crush" "Smashing Pumpkins" "Gish" "293423478" "4" date1 200 date1.1)) 
(define date1 (make-date 1991 8 20 0 0 0))
(define date1.1 (make-date 2020 6 14 3 2 1))
(define U21 (make-track "Where the Streets Have No Name" "U2" "The Joshua Tree" "39487534" date2 78 date2.1))
(define date2 (make-date 1985 2 2 0 0 0))
(define date2.1 (make-date 2018 3 4 0 0 0))
(define LedZep1 (make-track "Wearing and Tearing" "Led Zeppelin" "Coda" "982347234" date3 5 date3.1))
(define date3 (make-date 1979 4 4 4 0 0 0))
(define date3.1 (make-date 2007 5 5 5 0 0 0))



(define-struct date [year month day hour minute second])


; A Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (between 1 and 12 inclusive), 
; day (between 1 and 31), hour (between 0 
; and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).

; Any Any Any Any Any Any Any Any -> Track or #false
; creates an instance of Track for legitimate inputs
; otherwise it produces #false
(define (create-track name artist album time
                      track# added play# played)
  ...)
 
; Any Any Any Any Any Any -> Date or #false
; creates an instance of Date for legitimate inputs 
; otherwise it produces #false
(define (create-date y mo day h m s)
  ...)
 
; String -> LTracks
; creates a list-of-tracks representation from the
; text in file-name (an XML export from iTunes)
(define (read-itunes-as-tracks file-name)
  ...)
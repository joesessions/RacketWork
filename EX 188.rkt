;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |EX 188|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time

(define quickysMail (make-email "quicky" 30 "HereItIs!!!"))
(define mehsMail (make-email "meh" 115 "Here yaaa gooo."))
(define slothsMail (make-email "sloth" 400 "I was sleeping."))


;emailSortByDate
;aloe -> aloe, sorted by date
(check-expect (emailSortByDate (list mehsMail quickysMail slothsMail))
              (list quickysMail mehsMail slothsMail))
(check-expect (emailSortByDate (list slothsMail mehsMail quickysMail))
              (list quickysMail mehsMail slothsMail))
(check-expect (emailSortByDate (list slothsMail))
              (list slothsMail))
(define (emailSortByDate aloe)
  (cond
    [(empty? aloe) '()]
    [(empty? (rest aloe)) aloe]
    [else (insertEmailByDate (first aloe) (emailSortByDate (rest aloe)))]))

;emailFirst?
;email, email -> bool
(check-expect (emailFirst? mehsMail quickysMail) false)
(check-expect (emailFirst? mehsMail slothsMail) true)
(check-expect (emailFirst? mehsMail mehsMail) true)
(define (emailFirst? m1 m2)
  (<= (email-date m1) (email-date m2)))

;insertEmailByDate
;email aloe -> aloe
(check-expect (insertEmailByDate mehsMail (list quickysMail slothsMail))
                (list quickysMail mehsMail slothsMail))
(check-expect (insertEmailByDate quickysMail (list mehsMail slothsMail))
              (list quickysMail mehsMail slothsMail))
(define (insertEmailByDate e aloe)
  (cond
    [(empty? aloe) '()]
    [(empty? (rest aloe)) aloe]
    [(emailFirst? e (first aloe)) (cons e aloe)]
    [else (cons (first aloe) (insertEmailByDate e (rest aloe)))]))
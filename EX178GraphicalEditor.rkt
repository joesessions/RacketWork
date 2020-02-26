;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname EX178GraphicalEditor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require racket/math)

(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

;create-editor
; 2 strings -> editor
(check-expect (create-editor "12" "34")
               (make-editor (cons "2" (cons "1" '())) (cons "3" (cons "4" '()))))
(define (create-editor pre post)
     (make-editor (reverse (explode pre)) (explode post))) 

; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
(define (editor-render ed)
  (overlay/align "left" "center"
               (beside
                 (text (implode (reverse (editor-pre ed))) 15 "black")
                 (rectangle 1 20 "solid" "red")
                 (text (implode (editor-post ed)) 15 "black"))
               (empty-scene 200 20)))


(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))

(check-expect (editor-kh (create-editor "cd" "fgh") "e")
              (create-editor "cde" "fgh"))
(check-expect (editor-kh (create-editor "cd" "fgh") "\b")
              (create-editor "c" "fgh"))
(check-expect (editor-kh (create-editor "" "fgh") "\b")
              (create-editor "" "fgh"))
(check-expect (editor-kh (create-editor "cd" "fgh") "left")
              (create-editor "c" "dfgh"))
(check-expect (editor-kh (create-editor "cd" "fgh") "right")
              (create-editor "cdf" "gh"))
(check-expect (editor-kh (create-editor "" "fgh") "left")
              (create-editor "" "fgh"))
(check-expect (editor-kh (create-editor "cd" "") "right")
              (create-editor "cd" ""))
(check-expect (editor-kh (create-editor "cd" "fgh") "\b")
              (create-editor "c" "fgh"))

(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-left ed)]
         
    [(key=? k "right") (editor-right ed)]
    [(key=? k "\b") (editor-bksp ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-letter ed k)]
    [else ed]))

(check-expect (editor-left (create-editor "cd" "fgh"))
              (create-editor "c" "dfgh"))
(check-expect (editor-left (create-editor "" "fgh"))
              (create-editor "" "fgh"))

;editor-left
;take and editor and moves the cursor to the left
(define (editor-left ed)
  (cond
      [(not (empty? (editor-pre ed)))
            (make-editor
                (rest (editor-pre ed))
                (cons (first (editor-pre ed)) (editor-post ed)))]
      [else ed]))



;editor-right
;take and editor and moves the cursor to the right
(define (editor-right ed)
  (cond
      [(not (empty? (editor-post ed)))
            (make-editor
                (cons (first (editor-post ed)) (editor-pre ed))
                (rest (editor-post ed)))]
      [else ed]))

(check-expect (editor-bksp (create-editor "cd" "fgh"))
              (create-editor "c" "fgh"))
(check-expect (editor-bksp (create-editor "" "cde"))
              (create-editor "" "cde"))

;editor-bksp
;backspacing
(define (editor-bksp ed)
  (cond
      [(empty? (editor-pre ed)) ed]
      [else (make-editor (rest (editor-pre ed)) (editor-post ed))]))

(check-expect (editor-letter (create-editor "cd" "fgh") "k")
              (create-editor "cdk" "fgh"))
(check-expect (editor-letter (create-editor "" "cde") "k")
              (create-editor "k" "cde"))

;editor-right
;take and editor and moves the cursor to the right
(define (editor-letter ed k)
   (make-editor (cons k (editor-pre ed)) (editor-post ed)))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))

(main "start")
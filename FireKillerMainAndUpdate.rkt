;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname FireKillerMainAndUpdate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;************************************

; MAIN AND UPDATE-TICK AND UPDATE-KEY

;************************************

;(define-struct ws [lvl gspd tick x planeState planeWater flyingBombs groundItems])
;#lang racket ;  foo.rkt
(require "provide.rkt")
(provide (all-defined-out))
(define (new-planewater-drop nb)
  (- nb 1))
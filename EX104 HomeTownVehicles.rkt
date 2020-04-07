;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |EX104 HomeTownVehicles|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;***DataDefinitionForVehicles
;represents a vehicle by type, No of passengers, License Plate #, Fuel consumption

(define-struct vehicle [type passengers plate-no mpgs])

(define (passenger-miles-per-gallon veh)
  ...(vehicle-passengers veh)...(vehicle-mpgs)...)

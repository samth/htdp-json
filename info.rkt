#lang info
(define collection "2htdp")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"
                     "htdp-lib"))
(define scribblings '(("scribblings/htdp-json.scrbl" ())))
(define pkg-desc "Teaching library for JSON")
(define version "0.1")
(define pkg-authors '(samth))

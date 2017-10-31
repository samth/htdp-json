#lang racket/base

(require 2htdp/batch-io)
(require net/url)

(require json)

(provide read-json/web read-json/file)

; read-json/web : String -> JSExpr
; Retrieves the remote file at the given URL and returns JSON data
(define (read-json/web url)
  (let-values ([(status header content)
                (http-sendrecv/url (string->url url))])
    (read-json content)))

; read-json/file : String -> JSExpr
; Retrieves the local file with the given name and returns JSON data
(define (read-json/file file)
  (string->jsexpr (read-file file)))
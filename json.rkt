#lang racket/base

(require (only-in net/http-easy get response-output)
         racket/match json racket/file)
(provide read-json/web read-json/file
         (struct-out object)
         (struct-out member))

(define-struct object (members) #:transparent)
(define-struct member (name value) #:transparent)

; read-json/web : String -> JSON
; Retrieves the remote file at the given URL and returns JSON data
(define (read-json/web url)
  (define res (get url #:stream? #t #:headers (hash 'Accept "*/*")))
  (convert (read-json (response-output res))))

; read-json/file : String -> JSON
; Retrieves the local file with the given name and returns JSON data
(define (read-json/file file)
  (convert (string->jsexpr (file->string file))))

;; convert to a more student-friendly format
(define (convert jsexpr)
  (match jsexpr
    [(or (? number?) (? string?)) jsexpr]
    ['null "null"]
    [#t "true"]
    [#f "false"]
    [(? list? l) (map convert jsexpr)]
    [(? hash? h)
     (make-object (hash-map h (lambda (k v) (make-member (symbol->string k)
                                                         (convert v)))))]))

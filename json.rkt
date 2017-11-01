#lang racket/base

(require net/url racket/match json racket/file)
(provide read-json/web read-json/file
         (struct-out object)
         (struct-out null))

(define-struct object (entries) #:transparent)
(define-struct null () #:transparent)
(define the-null (make-null))

; read-json/web : String -> JSON
; Retrieves the remote file at the given URL and returns JSON data
(define (read-json/web url)
  (let-values ([(status header content)
                (http-sendrecv/url (string->url url))])
    (convert (read-json content))))

; read-json/file : String -> JSON
; Retrieves the local file with the given name and returns JSON data
(define (read-json/file file)
  (convert (string->jsexpr (file->string file))))

;; convert to a more student-friendly format
(define (convert jsexpr)
  (match jsexpr
    [(or #t #f (? number?) (? string?)) jsexpr]
    ['null the-null]
    [(? list? l) (map convert jsexpr)]
    [(? hash? h)
     (make-object (hash-map h (lambda (k v) (list (symbol->string k)
                                                  (convert v)))))]))

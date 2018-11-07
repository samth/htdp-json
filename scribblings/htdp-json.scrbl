#lang scribble/manual
@require[@for-label[2htdp/json (except-in racket/base null? null member) racket/contract/base]]

@title{htdp-json: A JSON library for use with HtDP}
@author{Sam Tobin-Hochstadt}

@defmodule[2htdp/json]

@defproc[(read-json/web [url string?]) any/c]{Fetches JSON
from the web.}

@defproc[(read-json/file [filename string?]) any/c]{Parses JSON from
the file system.}

@defproc[(null? [v any/c]) boolean?]{Recognizes null elements in JSON.}
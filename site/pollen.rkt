#lang racket/base
(require pollen/decode pollen/misc/tutorial txexpr)
(provide (all-defined-out))

#| site globals |#
(define site-name "sloane.sh")
(define email "sloane@fastmail.com")

#| custom elements |#

#| plain text decoding |#
(define txexpr-elements-proc decode-paragraphs)
(define string-proc (compose1 smart-quotes smart-dashes))
(define (root . elements)
   (txexpr 'root empty (decode-elements elements
     #:txexpr-elements-proc txexpr-elements-proc
     #:string-proc string-proc)))

#| setup |#
(module setup racket/base
  (provide (all-defined-out)))

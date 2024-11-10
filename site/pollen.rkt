#lang racket/base
(require pollen/decode pollen/misc/tutorial txexpr)
(provide (all-defined-out))

#| utilities |#
(define (splice  xs)
  (apply append (for/list  ([x (in-list xs)])
                  (if (and (txexpr? x) (member (get-tag x) '(splice-me)))
                    (get-elements x)
                    (list x)))))

#| site globals |#
(define site-name "sloane.sh")
(define email "sloane@fastmail.com")

#| custom elements |#
(define (title . elements)
  (txexpr 'h1 empty elements))
(define (subtitle . elements)
  (txexpr 'p '((class "subtitle")) elements))
(define (heading . elements)
  (txexpr 'h2 empty elements))
(define (low-level-heading . elements)
  (txexpr 'h3 empty elements))
(define (link dest . elements)
  (txexpr 'a `((href ,dest)) elements))
(define (unordered-list . elements)
  (txexpr 'ul empty elements))
(define (item . elements)
  (txexpr 'li empty elements))

(define (side-note label . elements)
  `(splice-me
     (label ((for ,label) (class "margin-toggle sidenote-number")))
     (input ((id ,label) (class "margin-toggle")(type "checkbox")))
     (span  ((class "sidenote")) ,@elements)))

#| plain text decoding |#
(define txexpr-elements-proc (compose1 decode-paragraphs splice))
(define string-proc (compose1 smart-quotes smart-dashes))
(define (root . elements)
   (txexpr 'article empty (decode-elements elements
     #:txexpr-elements-proc txexpr-elements-proc
     #:string-proc string-proc
     #:exclude-tags '(pre))))

#| setup |#
(module setup racket/base
  (provide (all-defined-out)))

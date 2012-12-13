;; this strips the u from the uid (e.g. u23) and
;; returns the number except for uid == (r, b, u0)
(define (uid->num x mod)
   (define s (java.lang.String. {[x]}))
   (if (or (.equals s "r") (.equals s "b") (.equals s "u0"))
	x
	(% (java.lang.Integer.parseInt (.substring {[x]} 1)) mod)))


(define (getcolor x)
 (case (uid->num x 11)
  ((u0) "yellow")
  ((0) "darkviolet")
  ((-2 1) "blue")
  ((2) "orangered")
  ((3) "tan4")
  ((4) "chocolate")
  ((5) "deeppink2")
  ((6) "aquamarine1")
  ((7) "brown")
  ((8) "cyan1")
  ((9) "darkgreen")
  ((10) "navyblue")
  ((r)  "red")
  (else "black")))

(define bar {|})

(define (makenextid)
  (define n 0)
  (lambda()
    (set! n (+ n 1))
    n
  )
)

(define nextid (makenextid))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This should convert the list body into a graph, nodes and edges and it should 
; return a string representing the record for the main node in the body
; starting at <f1> and go to <fn> where n is the length of body.

(define (creategroupnode u n i sb)
  (define nodename {[u]n[n]p[i]})
  (.append sb 
     #{"#[nodename]#" [\n shape="circle"\n label=""\n];\n}#) 
   nodename
)

(define (create-edge x y sb)
  (.append sb {"[x]" -> "[y]":f0 \[\n id=[(nextid)] \n\];\n})
)

(define (processnode u n i term sb)
  (case (first term) 
   ((string) {<f[i]>[(second term)]\\n([(third term)])[bar]})
   ((group) 
       (creategroupnode u n i sb)
       (.append sb {"[u]n[n]":f[i] -> "[u]n[n]p[i]" \[\n id=[(nextid)] \n \]; \n})
       (for-each (lambda(x) (create-edge {[u]n[n]p[i]} x sb)) (map (lambda(x) (createnode x sb)) (rest term)))
       {<f[i]>[bar]})
   (else {<f[i]>ERROR[bar]})
  )
)


(define (process u n i body sb)
  (if (null? body)
       ""
      (string-append
         (processnode u n i (first body) sb)
         (process u n (+ i 1) (rest body) sb))))


(define (createnode thebody sb)
  (define u (first thebody))
  (define n (second thebody))
  (define name {[u]n[n]})
  (define subnodes (rest (third thebody)))
  (define recordbody (process u n 1 subnodes sb)) 
  (define newnodedef
	#{\n "#[name]#" [
label="<f0>#[u]#\\nn#[n]#|<f0a>\\<|#[recordbody]#<fe>\\>"
shape="record"
color="#[(getcolor u)]#"
];
}#
    ); close .add sb
  (.append sb newnodedef)
  name
)


(define (normalGraph name G)
 (define sb (java.lang.StringBuffer.))
 (define f (open-output-file {[name].dot}))
 (.append sb {digraph [name] \{\n})
 (createnode G sb)
 (.append sb "}")
 (display (.toString sb) f)
 (display {Normal Graph Exported To [name].dot}) (newline)
 (.close f)
 sb
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This converts list red-black tree into a graph, nodes and edges

(define (create-meta-node parent info i sb)
  (define name #{p#[i]#}# )
  (if (not (null? parent))
      (.append sb #{#[parent]# -> #[name]#;\n}#))
  (.append sb #{
"#[name]#" [
  shape="circle"
  label="#[(second info)]#"
  color="#[(getcolor (first info))]#"
];
}#
  ) ; close .append
  name
) ; close define



(define (create-leaf parent info i sb)
  (define u (first info))
  (define n (second info))
  (define name #{n#[i]#}#)
  (if (not (null? parent))
      (.append sb #{#[parent]# -> #[name]#:f0;\n}#))
  (.append sb #{
"#[name]#" [
  shape="record"
  label="<f0>#[u]#\\nn#[n]#|#[(third info)]#"
  color="#[(getcolor u)]#"
  #[(if (equal? (fourth info) 'hidden)
	#{  style="filled"\n  fillcolor="gray"}#
	"")]#
];
}#
  ) ; close .append
  name
) ; close define



(define (balanced-process p term sb)
  (case (first term) 
   ((string) {<f[i]>[(second term)]\\n([(third term)])[bar]})
   ((parent)
    (define id (create-meta-node p (second term) (nextid) sb))
    (for-each (lambda (x) (balanced-process (first x) (second x) sb))
	      (map (lambda (x) (list id x))
		   (third (second term))))
   )
   ((leaf) 
    (create-leaf p (second term) (nextid) sb))
   (else (display "ERROR"))
  )
)


(define (balancedGraph name G)
 (define sb (java.lang.StringBuffer.))
 (define f (open-output-file {[name].dot}))
 (.append sb {digraph [name] \{\n})
 (balanced-process () G sb)
 (.append sb "}")
 (display (.toString sb) f)
 (display {Balanced Graph Exported To [name].dot}) (newline)
 (.close f)
 sb
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RUN: dotty *.dot & java -cp jscheme.jar jscheme.REPL NewToDot.scm
;; TOJAVA: java -cp jscheme.jar:. jsint.Compile -v -p collabed.debug ToDot.scm
(define (runex)
  (load "examples.scm")
  (balancedGraph "btree14e" b-ex14e)
  (normalGraph "ntree14e" n-ex14e)
  (normalGraph "tree14a1" ex14a)
  (normalGraph "tree14b" ex14b)
  (normalGraph "tree14c" ex14c)
  (normalGraph "tree14d" ex14d)
  (normalGraph "tree14e" ex14e)
  (normalGraph "tree11" ex11)
  (normalGraph "tree12" ex12)
  (normalGraph "test13" ex13))

(define (collabed)
  (load "mset.scm")
  (normalGraph "ntree" ntree)
  (balancedGraph "btree" btree))


(runex)        ;; for generating paper examples
;;; (collabed) ;; for using with CollabEd editors

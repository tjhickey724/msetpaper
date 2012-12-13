; This should convert the list body into a graph, nodes and edges
; and it should return a string representing the record for the main node in the body
; starting at <f1> and go to <fn> where n is the length of body.

(define (process u n i body sb)
 (display (list '>>>>>> 'process u n i body 'sb))(newline)
  (if (null? body)
       ""
      (string-append
         (processnode u n i (first body) sb)
         (process u n (+ i 1) (rest body) sb))))

(define (creategroupnode u n i sb)
  (define nodename {[u]n[n]p[i]})
  (.append sb 
     #{"#[nodename]#" [\n shape="circle"\n label=""\n];\n}#) 
   nodename
)

(define (create-edge x y sb)
  (.append sb {[x] -> [y]:f0 \[\n id=[(nextid)] \n\];\n})
)

(define (processnode u n i term sb)
  (display (list '>>>>>>> 'processnode u n i term 'sb)) (newline)
  (case (first term) 
   ((string) {<f[i]>[(second term)]\\n([(third term)])[bar]})
   ((group) 
       (creategroupnode u n i sb)
       (.append sb {[u]n[n]:f[i] -> [u]n[n]p[i] \[\n id=[(nextid)] \n \]; \n})
       (for-each (lambda(x) (create-edge {[u]n[n]p[i]} x sb)) (map (lambda(x) (createnode x sb)) (rest term)))
       {<f[i]>[bar]})
   (else {<f[i]>ERROR[bar]})
  )
)

(define (drawgraph name G)
 (define sb (java.lang.StringBuffer.))
 (define f (open-output-file {[name].dot}))
 (display (list 'drawgraph name G))(newline)
 (.append sb {digraph [name] \{\n})
 (createnode G sb)
 (.append sb "}")

 (display (.toString sb) f)
 (.close f)
 sb
)



(define (getcolor x)
 (case x
  ((u0) "yellow")
  ((u1) "red")
  ((u2) "blue")
  ((u3) "darkgreen")
  ((u4) "tan4")
  (else "black")))



(define (createnode thebody sb)
  (define u (first thebody))
  (define n (second thebody))
  (define name {[u]n[n]})
  (define subnodes (rest (third thebody)))
  (define showdbg (begin (display (list 'createnode thebody 'sb)) (newline) (display "**********") (newline) (display sb) (newline) (display "**********") (newline)(newline) #t))

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
  {[u]n[n]}
)

(define ex1
'(u0 0
  (list 
   (group
    (u1 1
     (list
      (group 
        (u2 2 (list (string "Hello!  " visible)))
        (u2 4 (list (string "Hi!  " visible)))
       )
      (string "This is an " visible)
      (group 
        (u1 2 (list 
                     (string "interesting " hidden)   
                ))
	(u2 1 (list 
                     (group (u2 3 (list (string "very" visible))))  
                     (string "illustrative " visible)
                     (group (u3 1 (list (string " and simple " visible))))  
               ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)


(define ex0
 '(u0 0
   (
     (string "Hello!  " visible)
     (string "This is an " visible)
     (string "interesting " hidden)
     (string "illustrative " visible)
     (string "example!" visible)
   )
  )
)


(define ex11a
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an example" visible)
     )
    )
   )
  )
 )
)


(define ex11
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u1 1 (list 
                     (string "interesting " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)

(define ex12
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u3 0 (list 
                     (string "illustrative " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)

(define ex13
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u1 1 (list 
                     (string "interesting " visible)   
                ))
        (u3 0 (list 
                     (string "illustrative " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)


(define ex14a
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u1 1 (list 
                     (string "interesting " hidden)   
                ))
        (u3 0 (list 
                     (group (u1 2 (list (string "easy" visible))))
                     (string "illustrative " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)

(define ex14b
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u1 1 (list 
                     (group (u1 2 (list (string "easy" visible))))
                     (string "interesting " hidden)   
                ))
        (u3 0 (list 
                     (string "illustrative " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)

(define ex14c
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u1 1 (list 
                     (string "interesting " hidden)   
                     (group (u1 2 (list (string "easy" visible))))
                ))
        (u3 0 (list 
                     (string "illustrative " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)

(define ex14d
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u1 1 (list 
                     (string "interesting " hidden)   
                     (string "easy " visible)   
                ))
        (u3 0 (list 
                     (string "illustrative " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)

(define ex14e
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u1 1 (list 
                     (string "interesting " hidden)   
                ))
        (u2 0 (list 
                     (string "easy " visible)   
                ))
        (u3 0 (list 
                     (string "illustrative " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)


(define ex14
'(u0 0
  (list 
   (group
    (u1 0
     (list
      (string "This is an " visible)
      (group 
        (u1 1 (list 
                     (string "interesting " hidden)   
                ))
        (u3 0 (list 
                     (string "illustrative " visible)   
                ))
      )
      (string "example!" visible)
     )
    )
   )
  )
 )
)



(define bar {|})

(define (makenextid)
  (define n 0)
  (lambda()
    (set! n (+ n 1))
    n
  )
)

(define nextid (makenextid))


	
; hmmm. we could define the tree operations on these s-expressions ....
(define (insert u1 n1 str u n pos)
  'under-construction
)

(define (runimages)
   (drawgraph "tree14a1" ex14a)
   (drawgraph "tree14b" ex14b)
   (drawgraph "tree14c" ex14c)
   (drawgraph "tree14d" ex14d)
   (drawgraph "tree14e" ex14e)
   (drawgraph "tree11" ex11)
   (drawgraph "tree12" ex12)
   (drawgraph "test13" ex13)
)

(define (ri) (drawgraph "tmpn" tmp))

(define tmp
'(u0 0  (list
 (group
(u2147483647 0  (list
  (string "This is an " visible)
 (group
(u115276 0  (list
  (string "easy " visible)
))(u110627786 0  (list
  (string "illus" visible)
 (group
(u115276 1  (list
 (group
(u115276 2  (list
  (string "[" visible)
)) )
  (string "TRA" visible)
 (group
(u110627786 1  (list
  (string "}" visible)
)) )
)) )
  (string "tra" hidden)
  (string "tive " visible)
))(u2147483647 1  (list
  (string "interesting " hidden)
)) )
  (string "example!" visible)
)) )
))

	)

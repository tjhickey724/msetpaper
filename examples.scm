(define n-ex14e
  '(u0 0  (list
 (group
(u1 0  (list
  (string "This is an " visible)
 (group
(u1 1  (list
  (string "interesting " hidden)
))
(u115276 0  (list
  (string "easy " visible)
))
(u110339486 0  (list
  (string "illustrative " visible)
))
 )
  (string "example!" visible)
))
 )
))

)


(define b-ex14e
  '(parent (b "49 \\nv37" (
(parent (b "41 \\nv29" (
(parent (r "11 \\nv11" (
(parent (b "0 \\nv0" (
  (leaf (u0 0 "\\<" visible))
)))
(parent (b "11 \\nv11" (
  (leaf (u1 0 "\\<|This is an " visible))
)))
)))
(parent (r "30 \\nv18" (
(parent (b "12 \\nv0" (
  (leaf (u1 1 "\\<|interesting |\\>" hidden))
)))
(parent (b "18 \\nv18" (
(parent (r "5 \\nv5" (
  (leaf (u115276 0 "\\<|easy |\\>" visible))
)))
(parent (r "13 \\nv13" (
  (leaf (u110339486 0 "\\<|illustrative |\\>" visible))
)))
)))
)))
)))
(parent (b "8 \\nv8" (
(parent (b "8 \\nv8" (
  (leaf (u1 0 "example!|\\>" visible))
)))
(parent (b "0 \\nv0" (
  (leaf (u0 0 "\\>" visible))
)))
)))
)))

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



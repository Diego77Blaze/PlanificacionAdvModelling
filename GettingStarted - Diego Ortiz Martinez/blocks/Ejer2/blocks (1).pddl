(define (domain blocks)
  (:requirements :strips :typing)
  (:types pieza)
  (:predicates 
           (on ?x ?y)
         (ontable ?x)
         (clear ?x)
         (handempty)
         (holding ?x)
         )

  (:action pick-up;coger objeto
       :parameters (?x - pieza) ;bloque
       :precondition (and (clear ?x) ;no tiene nada encima
                            (ontable ?x) ;esta en la mesa
                            (handempty) ;la mano esta libre
        )
       :effect
       (and (not (ontable ?x));x ya no esta en mesa
       (not (clear ?x));x no tiene nada encima
       (not (handempty));mano no vacia
       (holding ?x));sujetando x
   )

     (:action put-down
       :parameters (?x - pieza)
       :precondition (and (not(clear ?x)) ;x tiene algo encima
                            (not(ontable ?x)) ;esta en la mesa
                            (not(handempty));la mano esta libre
        )
       :effect
       (and  (ontable ?x);x esta en mesa
       (clear ?x); x no tiene nada encima
       (handempty); manos vacias
       (not(holding ?x))); no esta sujetando x ya
   ) 

  (:action stack
       :parameters (?x ?y - pieza)
       :precondition (and (clear ?y) ;encima de y no hay nada
                            (not (handempty)) ;la mano tiene algo
                            (not (ontable ?x))  ;x no esta en la mesa
       )
       :effect
       (and (not(holding ?x));la mano suelta a x
       (clear ?x);no hay nada encima de x
       (not (clear ?y));ahora hay algo encima de x
        (handempty);la mano esta vacia
       (on ?x ?y));x esta encima de y
   )

  (:action unstack
       :parameters (?x ?y - pieza)
       :precondition (and (on ?x ?y);x esta encima de y
                     (clear ?x);x no tiene nada encima
                     (handempty)); la mano esta vacia
       :effect
       (and (holding ?x); se sujeta x
       (clear ?y); y no tiene nada encima
       (not (clear ?x));x tiene algo encima
       (not (handempty)); mano llena
       (not (on ?x ?y)));ya no esta x encima de y
   )  

 
)
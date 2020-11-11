(define (domain blocks)
  (:requirements :strips :typing)
  (:types pieza) ;definicion de tipos usados
  (:predicates ;definicion de predicados
           (on ?x ?y)
         (ontable ?x)
         (clear ?x)
         (handempty)
         (holding ?x)
         )
  (:action pick-up ;accion de coger pieza
       :parameters (?x - pieza) ;bloque
       :precondition (and (clear ?x) ;no tiene nada encima
                            (ontable ?x) ;esta en la mesa
                            (handempty) ;la mano esta libre
        )
       :effect
       (and (not (ontable ?x)); no esta x sobre la mesa
       (not (clear ?x));x tiene algo encima
       (not (handempty));tiene algo en las manos
       (holding ?x));sujeta x
   )

  (:action put-down ;accion de colocar pieza
      :parameters (?x - pieza)
      :precondition (and (not(clear ?x)) 
                          (not(ontable ?x)) ;esta en la mesa
                          (not(handempty));la mano esta libre
      )
      :effect
      (and  (ontable ?x)
      (clear ?x); x no tiene nada encima
      (handempty);manos vacios
      (not(holding ?x)));no sujeta x
  ) 

  (:action stack ;accion de apilar
      :parameters (?x ?y - pieza)
      :precondition (and (clear ?y) ;encima de y no hay nada
                          (not (handempty)) ;la mano tiene algo
                          (not (ontable ?x))  ;x no esta en la mesa
      )
      :effect
      (and (not(holding ?x));la mano suelta a x
      (clear ?x);no hay nada encima de x
      (not (clear ?y));ahora hay algo encima de y
      (handempty);la mano esta vacia
      (on ?x ?y));x esta encima de y
  )

(:action unstack ;accion de desapilar
      :parameters (?x ?y - pieza)
      :precondition (and (on ?x ?y);x esta encima de y
                         (clear ?x) ;no hay nada encima de x
                         (handempty));manos vacias
      :effect
      (and (holding ?x); sujeta x
      (clear ?y); y se queda sin nada encima
      (not (clear ?x));x tiene algo encima
      (not (handempty));no se tiene la mano vacia
      (not (on ?x ?y)));x ya no esta encima de y
  )  
  
   
)
(define (domain gripper)
   (:predicates (ROOM ?r);definimos los predicados: objetos y resultados de acciones (esta libre, donde esta el robot, etc)
                (BALL ?b)
                (GRIPPER ?g)
                (at-robby ?r)
                (at-ball ?b ?r)
                (free ?g)
                (carry ?g ?b))

   (:action move; accion para que el robot se mueva
       :parameters (?x ?y)
       :precondition (and (ROOM ?x) ;declaras que x e y son salas
                          (ROOM ?y)
                          (at-robby ?x); declaras que el robot está en la sala x
                     )
       :effect (and (at-robby ?y)
                    (not (at-robby ?x))
               )
   )
   (:action pick-up; accion para agarrar
       :parameters (?ball ?room ?gripper)
       :precondition (and (BALL ?ball)
                          (ROOM ?room)
                          (GRIPPER ?gripper)
                          (at-ball ?ball ?room); estan los dos en el mismo sitio
                          (at-robby ?room)
                          (free ?gripper); la mano tiene que estar libre
                     )
       :effect (and (carry ?gripper ?ball)
                    (not (at-ball ?ball ?room)) ;la bola ya no esta en esa habitacion
                    (not (free ?gripper));la mano ya no queda libre
               )
   )
   (:action drop; es lo contrario de coger
       :parameters (?ball ?room ?gripper)
       :precondition (and (BALL ?ball)
                          (ROOM ?room)
                          (GRIPPER ?gripper)
                          (carry ?gripper ?ball)
                          (at-robby ?room)
                     )
       :effect (and (at-ball ?ball ?room)
                    (free ?gripper)
                    (not (carry ?gripper ?ball))
               )
   )
)
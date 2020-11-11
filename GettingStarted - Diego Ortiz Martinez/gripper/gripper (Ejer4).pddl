(define (domain gripper)
    (:requirements :strips :typing)
        (:types room ball)
   (:predicates (ROOM ?r)
                (BALL ?b)
                (GRIPPER ?g)
                (at-robby ?r)
                (at-ball ?b ?r)
                (free ?g)
                (carry ?g ?b)
    )
   (:action move; accion para que el robot se mueva
       :parameters (?x - room ?y - room)
       :precondition (
                          at-robby ?x ; y que el robot esta en la sala x
                     )
       :effect (and (at-robby ?y)  
                    (not (at-robby ?x)) ; mueve al robot de x a y y borra que este en x
               )
   )
   
   (:action pick-up; accion para agarrar
       :parameters (?ball - ball ?room - room ?gripper)
       :precondition (and 
                          (GRIPPER ?gripper) ;declaras la mano
                          (at-ball ?ball ?room) ; la bola esta en la sala
                          (at-robby ?room)  ;el robot esta en la sala
                          (free ?gripper)   ; mano libre
                     )
       :effect (and (carry ?gripper ?ball) ;cojo la pelota
                    (not (at-ball ?ball ?room)) ; la pelota no esta en la habitacion
                    (not (free ?gripper)) ; y la mano no esta libre
               )
   )
   (:action drop; es lo contrario de coger
       :parameters (?ball - ball ?room - room?gripper)
       :precondition (and 
                          (GRIPPER ?gripper)    ;declaras la mano
                          (carry ?gripper ?ball) ;la mano lleva una bola
                          (at-robby ?room)  ;y el robot esta en una sala
                     )
       :effect (and (at-ball ?ball ?room) ;la bola ahora esta en la sala
                    (free ?gripper) ;la mano esta libre
                    (not (carry ?gripper ?ball)) ; la mano ya no lleva una bola
               )
   )
)
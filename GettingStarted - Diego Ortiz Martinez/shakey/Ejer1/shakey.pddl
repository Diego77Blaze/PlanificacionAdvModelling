(define (domain shakey)
    (:requirements :strips :typing :equality)
    (:types room box)
    (:predicates;declaracion de predicados
        (shakey_in ?r);declaracion de  en qué habitación está shakey
        (room_pasillo ?r);delcaración de qué habitación es el pasillo
        (box_in ?b ?r);declaración de en qué habitación está cada caja
        (on_box ?b);declaración de si shakey se ha subido a una caja
        (on_floor);declaracion de si shakey esta en el suelo
        (lights_on ?r);declaración de si las luces están encendidas en una habitación
    )
    
(:action move;shakey se mueve entre dos habitaciones
    :parameters (?r1 ?r2 - room)
    :precondition (and (shakey_in ?r1) ;shakey esta en habitacion 1
                        (on_floor); no esta encima de la caja
                        (not(shakey_in ?r2)) ; no esta en habitacion 2
                        (or (and(room_pasillo ?r1) (not(room_pasillo ?r2))) ;el movimeinto tiene que ser habitación-pasillo
                            (and(room_pasillo ?r2) (not(room_pasillo ?r1)))))
    :effect (and
        (shakey_in ?r2)
        (not(shakey_in ?r1)); se cambia de habitacion
    )
)

(:action push;empujar caja
    :parameters (?b - box ?r1 ?r2 - room)
    :precondition (and (not(= ?r1 ?r2)); no se empuja la caja a la misma habitacion
                        (on_floor);no esta encima de la caja
                        (or (and(room_pasillo ?r1) (not(room_pasillo ?r2))) ;el empuje tiene que ser habitación-pasillo
                            (and(room_pasillo ?r2) (not(room_pasillo ?r1))))
                       (not(box_in ?b ?r2));la caja no esta en la otra habitacion ya
                       (box_in ?b ?r1); la caja esta en la primera habitacion
                       (shakey_in ?r1); shakey esta en la primera habitacion
                       )
    :effect (and(not(box_in ?b ?r1)); se mueve la caja a la segunda habitacion
                    (box_in ?b ?r2)
                    )
)

(:action switch_on; encender luz
    :parameters (?r - room ?b - box)
    :precondition (and (on_box ?b); tiene que estar subido a una caja 
                        (box_in ?b ?r)
                        (not(lights_on ?r)); y que las luces estén apagadas
                        (shakey_in ?r)
                       )
    :effect (and (lights_on ?r); las luces se encienden
                    )
)

(:action climb_up ;escalar caja
    :parameters (?b - box ?r - room)
    :precondition (and(not(on_box ?b));no esta encima
                    (box_in ?b ?r);la caja y shakey estan en la misma habitacion
                    (shakey_in ?r)
                    (on_floor));shakey esta en el suelo
    :effect (and (on_box ?b);escala la caja
                 (not(on_floor)))
)

(:action climb_down ;bajarse de una caja
    :parameters (?b - box)
    :precondition (and (on_box ?b);esta encima
                  (not(on_floor)))
    :effect (and (not(on_box ?b));baja de la caja
                 (on_floor))
)
)
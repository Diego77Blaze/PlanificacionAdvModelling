(define (domain rocket)
    (:requirements :strips :typing :equality :adl)
    (:types cargo ;declaracion de tipos
    		rocket
    		human 
    		place
    )
    (:predicates;declaracion de predicados
        (rocket_at ?r ?p)
        (has_fuel ?r)
     	(taken_off ?r)
        (cargo_taken ?c)
        (human_taken ?h)
        (empty ?r)
        (unloaded_rocket ?r ?p)
       
    )
(:action go_to;desplazamiento del cohete entre dos lugares
  :parameters (?r - rocket ?p1 ?p2 - place)
  :precondition (and (not(= ?p1 ?p2));no son el mismo sitio
                     (rocket_at ?r ?p1);esta en el primer lugar
                 	 (taken_off ?r);ha despegado
                     )
  :effect (and 	(rocket_at ?r ?p2); esta en el segundo sitio y ya no en el primero
           			(not(rocket_at ?r ?p1))
           			)
)

(:action take_off ;despegar
    :parameters (?r - rocket)
    :precondition (and (has_fuel ?r);si tiene combustible
                            (not(taken_off ?r)); no ha despegado
                            (not(empty ?r)) ;si no esta vacio
  
    )
    :effect(and (not(has_fuel ?r)); se queda sin combustible
    						(taken_off ?r);ha despegado
            )
)
 
(:action fill_rocket_humans; se llena el cohete con humanos
		:parameters (?r - rocket ?h - human)
 		:precondition (and(empty ?r);el cochete esta vacíuo
                        (not(taken_off ?r));no ha despegado
                        (not(human_taken ?h)));no ha cogido humanos
        :effect(and(not(empty ?r));ya no esta vacio
                        (human_taken ?h));coge humanos
)

(:action fill_rocket_cargo; se llena el cohete con cargamento
		:parameters (?r - rocket ?c - cargo)
 		:precondition (and(empty ?r);esta vacio
                            (not(taken_off ?r));no ha despegado
                            (not(cargo_taken ?c)));no ha cogido cargamento
        :effect(and(not(empty ?r));ya no esta vacio
                            (cargo_taken ?c));ha cogido el cargamento
)

(:action land_rocket;aterriza el cohete
	    :parameters(?r - rocket ?p - place)
        :precondition(and (taken_off ?r);ha despegado
                            (rocket_at ?r ?p)); esta en un lugar
        :effect(not(taken_off ?r));aterriza
) 

(:action unload_rocket;se descarga el contenido del cohete
	    :parameters(?r - rocket ?p - place)
        :precondition (and(not(taken_off ?r));esta en el suelo
                        (not(empty ?r)) ;no esta vacio
                        (rocket_at ?r ?p));esta en un lugar
	    :effect(and (empty ?r);se vacia el cohete
                        (unloaded_rocket ?r ?p));se descarga el cohete
))


(define (domain building)
  (:requirements :typing :durative-actions);requirements definition
  (:types 	lift - object ;types definition
			slow_lift fast_lift - lift
   			person - object
          	number - object
         )

(:predicates ;predicates definition
	(person_at ?person - person ?floor - number) ;indica si una persona está en un piso
	(lift_at ?l - lift ?floor - number) ;indica si un ascensor está en un piso
	(boarded ?person - person ?l - lift) ;indica si una persona se ha subido a un ascensor
	(above ?floor1 - number ?floor2 - number) ;para indicar qué piso está encima de otro
	(supports ?l - lift ?n - number) ;para ver si se pueden subir más personas al ascensor
	(can_stop ?l - lift ?floor - number) ;para saber si el ascensor para en una planta
	(next_nbr ?n1 - number ?n2 - number) ;para ver si el siguiente piso en una dirección es el correcto
	(passengers ?l - lift ?n - number) ;para controlar el numero de pasajeros en un ascensor
)

(:functions ;functions definition
            (travel_slow ?from - number ?to - number) ;coste del viaje lento
            (travel_fast ?from - number ?to - number) ;coste del viaje rapido
)

(:durative-action move_up_slow ;slow lift up movement
  :parameters (?l - slow_lift ?from - number ?to - number )
  :duration (= ?duration (travel_slow ?from ?to))
  :condition (and
				(at start (lift_at ?l ?from));el ascensor está en el origen
				(at start (above ?from ?to));va hacia arriba
				(at start (can_stop ?l ?to));mira si puede parar en el destino
				)
  :effect (and
				(at end (lift_at ?l ?to));el ascensor llega al destino
				(at start (not (lift_at ?l ?from)));ya no está en el origen
				)
)

(:durative-action move_down_slow ;slow lift down movement
  :parameters (?l - slow_lift ?from - number ?to - number )
  :duration (= ?duration (travel_slow ?to ?from))
  :condition (and
				(at start (lift_at ?l ?from));el ascensor está en el origen
				(at start (above ?to ?from));va hacia abajo
				(at start (can_stop ?l ?to));puede parar en el destino
				)
  :effect (and
			(at end (lift_at ?l ?to));el ascensor llega al destino
			(at start (not (lift_at ?l ?from)));ya no está en el origen
			)
)

(:durative-action move_up_fast ;fast lift up movement
  :parameters (?l - fast_lift ?from - number ?to - number )
  :duration (= ?duration (travel_fast ?from ?to))
  :condition (and
				(at start (lift_at ?l ?from));el ascensor está en el origen
				(at start (above ?from ?to));va hacia arriba
				(at start (can_stop ?l ?to));mira si puede parar en el destino
				)
  :effect (and
			(at end (lift_at ?l ?to));el ascensor llega al destino
			(at start (not (lift_at ?l ?from)));ya no está en el origen
			)
)

(:durative-action move_down_fast ;fast lift down movement
  :parameters (?l - fast_lift ?from - number ?to - number )
  :duration (= ?duration (travel_fast ?to ?from))
  :condition (and
                (at start (lift_at ?l ?from));el ascensor está en el origen
                (at start (above ?to ?from));va hacia abajo
                (at start (can_stop ?l ?to));puede parar en el destino
				)
  :effect (and
			(at end (lift_at ?l ?to));el ascensor llega al destino
			(at start (not (lift_at ?l ?from)));ya no está en el origen
			)
)

(:durative-action board ;person gets into the lift
  :parameters (?p - person ?l - lift ?f - number ?n1 - number ?n2 - number)
  :duration (= ?duration 1)
  :condition (and
				(over all (lift_at ?l ?f));el ascensor está en un piso
				(at start (person_at ?p ?f));la persona está en ese mismo piso
				(at start (passengers ?l ?n1));comprueba el numero de pasajeros
				(at start (next_nbr ?n1 ?n2));comprueba la diferencia entre el numero de pasajeros
				(at start (supports ?l ?n2));comprueba que se puede subir uno más
				)
  :effect (and
				(at start (not (person_at ?p ?f)));la persona deja de estar en el piso
				(at end (boarded ?p ?l));la persona se sube al ascensor
				(at start (not (passengers ?l ?n1)));pasan de ser los que estaban subidos
				(at end (passengers ?l ?n2));a ser uno mas
				)
)

(:durative-action leave ;person leaves the lift
  :parameters (?p - person ?l - lift ?f - number ?n1 - number ?n2 - number)
  :duration (= ?duration 1)
  :condition (and
				(over all (lift_at ?l ?f));el ascensor esta en un piso
				(at start (boarded ?p ?l));la persona esta subida en el ascensor
				(at start (passengers ?l ?n1));comprueba el numero de pasajeros
				(at start (next_nbr ?n2 ?n1));comprueba que se va a disminuir en 1 el numero de pasajeros
				)
  :effect (and
				(at end (person_at ?p ?f));la persona pasa a estar en una planta
				(at start (not (boarded ?p ?l)));la persona ya no está en el ascensor
				(at start (not (passengers ?l ?n1)));ya no van a ser n1 (que en este caso es el numero mayor)
				(at end (passengers ?l ?n2));van a ser uno menos
				)
)

)

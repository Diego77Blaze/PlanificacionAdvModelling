(define (domain building)
  (:requirements :typing :durative-actions)
  (:types 	lift - object
			slow_lift fast_lift - lift
   			person - object
          	number - object
         )

(:predicates
	(person_at ?person - person ?floor - number)
	(lift_at ?l - lift ?floor - number)
	(boarded ?person - person ?l - lift)
	(above ?floor1 - number ?floor2 - number)
	(supports ?l - lift ?n - number)
	(can_stop ?l - lift ?floor - number)
	(next_floor ?n1 - number ?n2 - number)
	(passengers ?l - lift ?n - number)
)

(:functions
            (travel_slow ?from - number ?to - number)
            (travel_fast ?from - number ?to - number)
)

(:durative-action move_up_slow
  :parameters (?l - slow_lift ?from - number ?to - number )
  :duration (= ?duration (travel_slow ?from ?to))
  :condition (and 
				(at start (lift_at ?l ?from)) 
				(at start (above ?from ?to)) 
				(at start (can_stop ?l ?to)) 
				)
  :effect (and 
				(at end (lift_at ?l ?to)) 
				(at start (not (lift_at ?l ?from))) 
				)
)

(:durative-action move_down_slow
  :parameters (?l - slow_lift ?from - number ?to - number )
  :duration (= ?duration (travel_slow ?to ?from))
  :condition (and 
				(at start (lift_at ?l ?from)) 
				(at start (above ?to ?from)) 
				(at start (can_stop ?l ?to))
				)
  :effect (and 
			(at end (lift_at ?l ?to)) 
			(at start (not (lift_at ?l ?from)))
			)
)

(:durative-action move_up_fast
  :parameters (?l - fast_lift ?from - number ?to - number )
  :duration (= ?duration (travel_fast ?from ?to))
  :condition (and 
				(at start (lift_at ?l ?from))
				(at start (above ?from ?to))
				(at start (can_stop ?l ?to))
				)
  :effect (and 
			(at end (lift_at ?l ?to))
			(at start (not (lift_at ?l ?from)))
			)
)

(:durative-action move_down_fast
  :parameters (?l - fast_lift ?from - number ?to - number )
  :duration (= ?duration (travel_fast ?to ?from))
  :condition (and 
				(at start (lift_at ?l ?from))
				(at start (above ?to ?from)) 
				(at start (can_stop ?l ?to)) 
				)
  :effect (and 
			(at end (lift_at ?l ?to)) 
			(at start (not (lift_at ?l ?from))) 
			)
)

(:durative-action board
  :parameters (?p - person ?l - lift ?f - number ?n1 - number ?n2 - number)
  :duration (= ?duration 1)
  :condition (and  
				(over all (lift_at ?l ?f))
				(at start (person_at ?p ?f))
				(at start (passengers ?l ?n1)) 
				(at start (next_floor ?n1 ?n2)) 
				(at start (supports ?l ?n2)) 
				)
  :effect (and 
				(at start (not (person_at ?p ?f))) 
				(at end (boarded ?p ?l)) 
				(at start (not (passengers ?l ?n1))) 
				(at end (passengers ?l ?n2)) 
				)
)

(:durative-action leave
  :parameters (?p - person ?l - lift ?f - number ?n1 - number ?n2 - number)
  :duration (= ?duration 1)
  :condition (and  
				(over all (lift_at ?l ?f)) 
				(at start (boarded ?p ?l)) 
				(at start (passengers ?l ?n1)) 
				(at start (next_floor ?n2 ?n1)) 
				)
  :effect (and 
				(at end (person_at ?p ?f)) 
				(at start (not (boarded ?p ?l))) 
				(at start (not (passengers ?l ?n1))) 
				(at end (passengers ?l ?n2)) 
				)
)

)

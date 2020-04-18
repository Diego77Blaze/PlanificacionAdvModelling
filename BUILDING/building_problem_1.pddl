(define (problem building_problem1)
(:domain building)

(:objects
n0 n1 n2 n3 n4 - number
p0 p1 - person
fast0 fast1  - fast_lift
slow0 slow1 - slow_lift
)

(:init

(person_at p0 n3)
(person_at p1 n1)

(lift_at fast0 n0)
(lift_at fast1 n0)
(lift_at slow0 n0)
(lift_at slow1 n0)

(passengers fast0 n0)
(passengers fast1 n0)
(passengers slow0 n0)
(passengers slow1 n0)

(supports fast0 n1) (supports fast0 n2) (supports fast0 n3)
(supports fast1 n1) (supports fast1 n2) (supports fast1 n3)
(supports slow0 n1) (supports slow0 n2)
(supports slow1 n1) (supports slow1 n2)

(can_stop fast0 n0)(can_stop fast0 n2)(can_stop fast0 n4)
(can_stop fast1 n0)(can_stop fast1 n2)(can_stop fast1 n4)
(can_stop slow0 n0)(can_stop slow0 n1)(can_stop slow0 n2)(can_stop slow0 n3)(can_stop slow0 n4)
(can_stop slow0 n0)(can_stop slow0 n1)(can_stop slow0 n2)(can_stop slow0 n3)(can_stop slow0 n4)

(next_floor n0 n1)
(next_floor n1 n2) 
(next_floor n2 n3) 
(next_floor n3 n4)

(above n0 n1) (above n0 n2) (above n0 n3) (above n0 n4)
(above n1 n2) (above n1 n3) (above n1 n4)
(above n2 n3) (above n2 n4)
(above n3 n4)

(= (travel_slow n0 n1) 12)
(= (travel_slow n0 n2) 20)
(= (travel_slow n0 n3) 28)
(= (travel_slow n0 n4) 36)
(= (travel_slow n1 n2) 12)
(= (travel_slow n1 n3) 20)
(= (travel_slow n1 n4) 28)
(= (travel_slow n2 n3) 12)
(= (travel_slow n2 n4) 20)
(= (travel_slow n3 n4) 12)
(= (travel_fast n0 n2) 11) 
(= (travel_fast n0 n4) 13)
(= (travel_fast n2 n4) 11)


)

(:goal
(and
(person_at p0 n4)
(person_at p1 n3)
))

(:metric minimize (total-time))

)

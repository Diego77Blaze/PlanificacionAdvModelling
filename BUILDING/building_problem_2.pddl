(define (problem building_problem2)
(:domain building)

(:objects
n0 n1 n2 n3 n4 n5 n6 n7 n8  - number
p0 p1 p2 p3  - person
fast0 fast1  - fast_lift
slow0 slow1 - slow_lift
)

(:init

(person_at p0 n0);where is the people
(person_at p1 n0)
(person_at p2 n0)
(person_at p3 n0)

(lift_at fast0 n8);where are the lifts
(lift_at fast1 n6)
(lift_at slow0 n4)
(lift_at slow1 n4)

(passengers fast0 n0);number of passengers
(passengers fast1 n0)
(passengers slow0 n0)
(passengers slow1 n0)

(supports fast0 n1) (supports fast0 n2) (supports fast0 n3);how many the lift supports
(supports fast1 n1) (supports fast1 n2) (supports fast1 n3)
(supports slow0 n1) (supports slow0 n2)
(supports slow1 n1) (supports slow1 n2)

(can_stop fast0 n0)(can_stop fast0 n2)(can_stop fast0 n4)(can_stop fast0 n6)(can_stop fast0 n8);where can the lift stop
(can_stop fast1 n0)(can_stop fast1 n2)(can_stop fast1 n4)(can_stop fast1 n6)(can_stop fast1 n8)
(can_stop slow0 n0)(can_stop slow0 n1)(can_stop slow0 n2)(can_stop slow0 n3)(can_stop slow0 n4)(can_stop slow1 n5)(can_stop slow1 n6)(can_stop slow1 n7)(can_stop slow1 n8)
(can_stop slow0 n0)(can_stop slow0 n1)(can_stop slow0 n2)(can_stop slow0 n3)(can_stop slow0 n4)(can_stop slow1 n5)(can_stop slow1 n6)(can_stop slow1 n7)(can_stop slow1 n8)

(next_nbr n0 n1);next numbers
(next_nbr n1 n2)
(next_nbr n2 n3)
(next_nbr n3 n4)
(next_nbr n4 n5)
(next_nbr n5 n6)
(next_nbr n6 n7)
(next_nbr n7 n8)

(above n0 n1) (above n0 n2) (above n0 n3) (above n0 n4) (above n0 n5) (above n0 n6) (above n0 n7) (above n0 n8);floor distribution
(above n1 n2) (above n1 n3) (above n1 n4) (above n1 n5) (above n1 n6) (above n1 n7) (above n1 n8)
(above n2 n3) (above n2 n4) (above n2 n5) (above n2 n6) (above n2 n7) (above n2 n8)
(above n3 n4) (above n3 n5) (above n3 n6) (above n3 n7) (above n3 n8)
(above n4 n5) (above n4 n6) (above n4 n7) (above n4 n8)
(above n5 n6) (above n5 n7) (above n5 n8)
(above n6 n7) (above n6 n8)
(above n7 n8)

(= (travel_slow n0 n1) 12);duration of travels
(= (travel_slow n0 n2) 20)
(= (travel_slow n0 n3) 28)
(= (travel_slow n0 n4) 36)
(= (travel_slow n0 n5) 44)
(= (travel_slow n0 n6) 52)
(= (travel_slow n0 n7) 60)
(= (travel_slow n0 n8) 68)
(= (travel_slow n1 n2) 12)
(= (travel_slow n1 n3) 20)
(= (travel_slow n1 n4) 28)
(= (travel_slow n1 n5) 36)
(= (travel_slow n1 n6) 44)
(= (travel_slow n1 n7) 52)
(= (travel_slow n1 n8) 60)
(= (travel_slow n2 n3) 12)
(= (travel_slow n2 n4) 20)
(= (travel_slow n2 n5) 28)
(= (travel_slow n2 n6) 36)
(= (travel_slow n2 n7) 44)
(= (travel_slow n2 n8) 52)
(= (travel_slow n3 n4) 12)
(= (travel_slow n3 n5) 20)
(= (travel_slow n3 n6) 28)
(= (travel_slow n3 n7) 36)
(= (travel_slow n3 n8) 44)
(= (travel_slow n4 n5) 12)
(= (travel_slow n4 n6) 20)
(= (travel_slow n4 n7) 28)
(= (travel_slow n4 n8) 36)
(= (travel_slow n5 n6) 12)
(= (travel_slow n5 n7) 20)
(= (travel_slow n5 n8) 28)
(= (travel_slow n6 n7) 12)
(= (travel_slow n6 n8) 20)
(= (travel_slow n7 n8) 12)

(= (travel_fast n0 n2) 11)
(= (travel_fast n0 n4) 13)
(= (travel_fast n0 n6) 15)
(= (travel_fast n0 n8) 17)
(= (travel_fast n2 n4) 11)
(= (travel_fast n2 n6) 13)
(= (travel_fast n2 n8) 15)
(= (travel_fast n4 n6) 11)
(= (travel_fast n4 n8) 13)
(= (travel_fast n6 n8) 11)

)

(:goal ;goal declaration
(and
(person_at p0 n4)
(person_at p1 n3)
(person_at p2 n2)
(person_at p3 n6)
))

(:metric minimize (total-time)) ;metric declaration

)

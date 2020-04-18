(define (domain cooperation)
	(:requirements :strips :typing :equality :negative-preconditions :fluents
		:durative-actions :preferences :constraints)
	(:types
		dock - object
		coordX - object
		coordY - object
		unmanned_vehicle - object
        UAV UGV - unmanned_vehicle
        navMode - object
        pan - object
        tilt - object
	)
	(:predicates
		(at ?elem - (either dock unmanned_vehicle) ?x - coordX ?y - coordY)
		(docked ?uv - unmanned_vehicle ?d - dock)
		(has_navMode ?uv - unmanned_vehicle ?m - navMode)
		(pictured ?uv - unmanned_vehicle ?x - coordX ?y - coordY ?p - pan ?t - tilt)
		(picture_sent ?uv - unmanned_vehicle ?x - coordX ?y - coordY ?p - pan ?t - tilt)
		(is_horizontal_pan ?uv - unmanned_vehicle ?p - pan)
		(is_horizontal_tilt ?uv - unmanned_vehicle ?t - tilt)
	)
	(:functions
		(speed ?m - navMode)
		(distance ?from_coordX - coordX ?from_coordY - coordY ?to_coordX - coordX ?to_coordY - coordY)
		(total_time)

	)

	(:durative-action dock
	   :parameters(?d - dock ?uv -unmanned_vehicle ?x - coordX ?y - coordY)
	   :duration(= ?duration 1)
       :condition(and
					(at start (at ?d ?x ?y))
					(at start (at ?uv ?x ?y))
				)
	   :effect(and
					(at start (not(at ?uv ?x ?y)))
					(at end (docked ?uv ?d))
					(at end (increase (total_time) 1))
				)
	)
	(:durative-action undock
	   :parameters(?d - dock ?uv -unmanned_vehicle ?x - coordX ?y - coordY)
	   :duration(= ?duration 1)
       :condition(and
					(at start (at ?d ?x ?y))
				)
	   :effect(and
					(at start (not(docked ?uv ?d)))
					(at end (at ?uv ?x ?y))
					(at end (increase (total_time) 1))
				)
	)
	(:durative-action move
		:parameters(?uv - unmanned_vehicle ?fromX - coordX  ?fromY - coordY ?toX - coordX ?toY - coordY ?mode - navMode)
		:duration(= ?duration (/(speed ?mode)(distance ?fromX ?fromY ?toX ?toY)))
        :condition(and
					(at start (has_navMode ?uv ?mode))
					(at start (at ?uv ?fromX ?fromY))
				)
        :effect (and
					(at start (not(at ?uv ?fromX ?fromY)))
					(at end (at ?uv ?toX ?toY))
					(at end (increase (total_time) (/(speed ?mode)(distance ?fromX ?fromY ?toX ?toY))))
				)
    )
	(:durative-action take_picture
        :parameters(?uv - unmanned_vehicle ?x - coordX ?y - coordY ?p - pan ?t - tilt)
		:duration(= ?duration 1)
        :condition(and
					(at start (at ?uv ?x ?y))
        )
		:effect (and
					(at end (pictured ?uv ?x ?y ?p ?t))
					(at end (increase (total_time) 1))
				)
    )

	(:durative-action change_rotation
		:parameters(?uv - unmanned_vehicle ?pan1 ?pan2 - pan ?tilt1 ?tilt2 - tilt)
		:duration(= ?duration 1)
 		:condition(and
					(at start (is_horizontal_pan ?uv ?pan1))
					(at start (is_horizontal_tilt ?uv ?tilt1))
		)
		:effect(and
					(at end (is_horizontal_pan ?uv ?pan2))
					(at end (is_horizontal_tilt ?uv ?tilt2))
					(at end (increase (total_time) 1))
				)
	)

	(:durative-action change_navMode
		:parameters(?uv - unmanned_vehicle ?mode1 ?mode2 - navMode)
		:duration(= ?duration 1)
		:condition(at start (has_navMode ?uv ?mode1))
		:effect(and
					(at end (has_navMode ?uv ?mode2))
					(at end (increase (total_time) 1))
				)
	)

	(:durative-action send_picture
		:parameters(?uv - unmanned_vehicle ?x - coordX ?y - coordY ?p - pan ?t - tilt)
		:duration(= ?duration 1)
		:condition(and
						(at start (pictured ?uv ?x ?y ?p ?t))
					)
		:effect(and
					(at end(picture_sent ?uv ?x ?y ?p ?t))
					(at end (increase (total_time) 1))
				)
	)


)

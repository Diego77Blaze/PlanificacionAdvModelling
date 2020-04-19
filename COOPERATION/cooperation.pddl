(define (domain cooperation)
	(:requirements :strips :typing :equality :negative-preconditions :fluents ;requirements declaration
		:durative-actions :preferences :constraints)
	(:types ;type declaration
		dock - object
		coordX coordY - object
		unmanned_vehicle - object
        UAV UGV - unmanned_vehicle
        navMode - object
        pan - object
        tilt - object
	)
	(:predicates ;predicate declaration
		(at ?elem - (either dock unmanned_vehicle) ?x - coordX ?y - coordY) ;mira si un dock o un vehiculo no tripulado está en unas coordenadas en concreto
		(docked ?uv - unmanned_vehicle ?d - dock) ;comprueba si un vehiculo está en el dock
		(has_navMode ?uv - unmanned_vehicle ?m - navMode) ;comprueba el modo de navegacion del vehiculo
		(pictured ?uv - unmanned_vehicle ?x - coordX ?y - coordY ?p - pan ?t - tilt) ;comprueba si ha tomado una foto en unas coordenadas con una perspectiva en concreto
		(picture_sent ?uv - unmanned_vehicle ?x - coordX ?y - coordY ?p - pan ?t - tilt) ;comprueba si se ha enviado la imagen
		(is_pan ?uv - unmanned_vehicle ?p - pan) ;comprueba el pan
		(is_tilt ?uv - unmanned_vehicle ?t - tilt) ;comprueba el tilt
	)
	(:functions ;function declaration
		(speed ?m - navMode) ;velocidad segun el modo de navegacion
		(distance ?x1 - coordX ?y1 - coordY ?x2 - coordX ?y2 - coordY) ;distancia entre dos posiciones
		(total_time) ;tiempo total

	)
	;El vehiculo se estaciona en el dock
	(:durative-action dock
	   :parameters(?d - dock ?uv -unmanned_vehicle ?x - coordX ?y - coordY)
	   :duration(= ?duration 1)
       :condition(and
					(at start (at ?d ?x ?y));el dock y el vehiculo estan en la misma posicion
					(at start (at ?uv ?x ?y))
				)
	   :effect(and
					(at start (not(at ?uv ?x ?y)));deja de estar en esa posicion
					(at end (docked ?uv ?d));porque pasa a estar en el dock
					(at end (increase (total_time) 1));se incrementa el tiempo
				)
	)
	;El vehiculo sale del dock
	(:durative-action undock
	   :parameters(?d - dock ?uv -unmanned_vehicle ?x - coordX ?y - coordY)
	   :duration(= ?duration 1)
       :condition(and
					(at start (at ?d ?x ?y));el dock esta en su posicion
				)
	   :effect(and
					(at start (not(docked ?uv ?d)));deja de estar en el dock el vehiculo
					(at end (at ?uv ?x ?y));pasa a estar en unas coordenadas
					(at end (increase (total_time) 1));se incrementa el tiempo
				)
	)
	;El vehiculo se desplaza entre dos posiciones
	(:durative-action move
		:parameters(?uv - unmanned_vehicle ?fromX - coordX  ?fromY - coordY ?toX - coordX ?toY - coordY ?mode - navMode)
		:duration(= ?duration (/(distance ?fromX ?fromY ?toX ?toY)(speed ?mode)))
        :condition(and
					(at start (has_navMode ?uv ?mode));el vehiculo tiene el modo de navegacion correspondiente
					(at start (at ?uv ?fromX ?fromY));el vehiculo esta en el origen
				)
        :effect (and
					(at start (not(at ?uv ?fromX ?fromY)));deja de estar en el origen
					(at end (at ?uv ?toX ?toY));pasa a estar en la meta
					(at end (increase (total_time) (/(speed ?mode)(distance ?fromX ?fromY ?toX ?toY))));se incrementa el tiempo dependiendo de la distancia y la velocidad
				)
    )
	;El vehiculo toma una imagen en una posicion concreta y con un pan y un tilt determinados
	(:durative-action take_picture
        :parameters(?uv - unmanned_vehicle ?x - coordX ?y - coordY ?p - pan ?t - tilt)
		:duration(= ?duration 1)
        :condition(and
					(at start (is_pan ?uv ?p));comprueba el pan, el tilt, y la posicion
					(at start (is_tilt ?uv ?t))
					(at start (at ?uv ?x ?y))
        )
		:effect (and
					(at end (pictured ?uv ?x ?y ?p ?t));se toma una imagen del lugar
					(at end (increase (total_time) 1));se incrementa el tiempo
				)
    )
	;Se cambia la rotacion (pan y tilt)
	(:durative-action change_rotation
		:parameters(?uv - unmanned_vehicle ?pan1 ?pan2 - pan ?tilt1 ?tilt2 - tilt)
		:duration(= ?duration 1)
 		:condition(and  (at start (is_pan ?uv ?pan1));se comprueba que el pan y el tilt son los iniciales
						(at start (is_tilt ?uv ?tilt1)))
		:effect(and
					(at start (not(is_pan ?uv ?pan1)));deja de ser el pan inicial para ser el pan final
					(at end (is_pan ?uv ?pan2))
					(at start (not(is_tilt ?uv ?tilt1)));deja de ser el tilt inicial para ser el tilt final
					(at end (is_tilt ?uv ?tilt2))
					(at end (increase (total_time) 1));se incrementa el tiempo
				)
	)

	;Se cambia el modo de navegacion
	(:durative-action change_navMode
		:parameters(?uv - unmanned_vehicle ?mode1 ?mode2 - navMode)
		:duration(= ?duration 1)
		:condition(at start (has_navMode ?uv ?mode1));comprueba que el modo de navegacion es el inicial
		:effect(and
					(at start (not(has_navMode ?uv ?mode1)));cambia de modo inicial al modo final
					(at end (has_navMode ?uv ?mode2))
					(at end (increase (total_time) 1));se incrementa el tiempo
				)
	)
	;Se envia la imagen
	(:durative-action send_picture
		:parameters(?uv - unmanned_vehicle ?x - coordX ?y - coordY ?p - pan ?t - tilt)
		:duration(= ?duration 1)
		:condition(and
						(at start (at ?uv ?x ?y));se comprueban la posicion, el pan y el tilt
						(at start (is_pan ?uv ?p))
						(at start (is_tilt ?uv ?t))
						(at start (pictured ?uv ?x ?y ?p ?t));se ha tenido que fotografiar primero
					)
		:effect(and
					(at end(picture_sent ?uv ?x ?y ?p ?t));se envia la imagen
					(at end (increase (total_time) 1));se incrementa el tiempo
				)
	)
)

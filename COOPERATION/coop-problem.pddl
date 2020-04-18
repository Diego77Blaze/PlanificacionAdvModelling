(define (problem cooperation-problem)
	(:domain cooperation)
	(:objects
		dock1 - dock
		x_1 x_5 x_6 x_10 x_16 - coordX
		y_1 y_2 y_9 y_10 y_13 - coordY
		Leader - UGV
		Follower0 - uav
		N0 N1 - navmode
		P_0 P_45 P_90 P_135 P_180 P_225 P_270 P_315 - pan
		T_0 T_45 T_90 T_270 T_315 - tilt
	)

	(:init
		(at dock1 x_1 y_1)
		(at Leader x_6 y_10)
		(at Follower0 x_10 y_2)
		(has_navMode Leader N0)
		(has_navMode Follower0 N0)
		(is_horizontal_pan Leader P_180)
		(is_horizontal_pan Follower0 P_0)
		(is_horizontal_tilt Leader T_315)
		(is_horizontal_tilt Follower0 T_0)

		(= (total_time) 0)

		(= (speed N0) 1)
		(= (speed N1) 2)

		(= (distance x_1 y_1 x_5 y_9) 5)
		(= (distance x_1 y_1 x_6 y_10) 6)
		(= (distance x_1 y_1 x_10 y_2) 5)
		(= (distance x_1 y_1 x_16 y_13) 10)

		(= (distance x_5 y_9 x_1 y_1) 5)
		(= (distance x_5 y_9 x_6 y_10) 2)
		(= (distance x_5 y_9 x_10 y_2) 5)
		(= (distance x_5 y_9 x_16 y_13) 9)

		(= (distance x_6 y_10 x_1 y_1) 6)
		(= (distance x_6 y_10 x_5 y_9) 5)
		(= (distance x_6 y_10 x_10 y_2) 5)
		(= (distance x_6 y_10 x_16 y_13) 6)

		(= (distance x_10 y_2 x_1 y_1) 5)
		(= (distance x_10 y_2 x_5 y_9) 5)
		(= (distance x_10 y_2 x_6 y_10) 5)
		(= (distance x_10 y_2 x_16 y_13) 10)

		(= (distance x_16 y_13 x_1 y_1) 10)
		(= (distance x_16 y_13 x_5 y_9) 9)
		(= (distance x_16 y_13 x_6 y_10) 6)
		(= (distance x_16 y_13 x_10 y_2) 10)
	)
	(:goal
		(and
			(pictured Leader x_5 y_9 P_0 T_0)
			(pictured Follower0 x_16 y_13 P_0 T_0)
		)
	)
	(:constraints
		(and
			(preference OUT-DOCK-UAV (always (not(docked Follower0 dock1))))
			(preference OUT-DOCK-UGV (sometime (docked Leader dock1)))
		)
	)
	(:metric minimize
		(+ 	(* 20 (total_time))
			(* 10 (is-violated OUT-DOCK-UAV))
			(* 4 (is-violated OUT-DOCK-UGV))
		)
	)
)

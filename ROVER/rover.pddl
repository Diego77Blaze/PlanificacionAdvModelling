(define (domain rover-domain)
    (:requirements :typing :durative-actions :fluents)
    (:types location)
    (:predicates
        (at ?l - location)
        (accessible ?l1 ?l2 - location)
        (moving)
        (picture_taken ?l - location)
        (drilled ?l - location)
        (analysed ?l - location)
        (communicated)
	)
    (:functions
        (cantidad_bateria )
        (bateria_usada )
        (bateria_requerida_moveslow ?l1 ?l2 - location)
        (bateria_requerida_movefast ?l1 ?l2 - location)
        (bateria_requerida_fotoslow)
        (bateria_requerida_fotofast)
        (bateria_requerida_drillslow)
        (bateria_requerida_drillfast)
        (bateria_requerida_analyseslow)
        (bateria_requerida_analysefast)
        (bateria_requerida_communicate)
        (umbral_bateria)
    )

    (:durative-action move_slow
        :parameters
            (?from - location
             ?to - location)

        :duration
            (= ?duration 5)

        :condition
	        (and
                (at start (not(moving)))
                (at start (at ?from))
                (at start (accessible ?from ?to))
                (at start (>= (cantidad_bateria ) (bateria_requerida_moveslow ?from ?to)))
                (at start (>= (cantidad_bateria ) (umbral_bateria))))


        :effect
	        (and
                (at start (moving ))
                (at end (not(moving )))
                (at end (not (at  ?from)))
                (at end (at  ?to))
                (at end(decrease (cantidad_bateria )(bateria_requerida_moveslow ?from ?to)))
                (at end(increase (bateria_usada )(bateria_requerida_moveslow ?from ?to)))
                )
	)

  (:durative-action take_picture_slow
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 2)

    :condition
      (and
              (at start (at  ?l))
              (at start (not (moving )))
              (at start (not (picture_taken ?l)))
              (at start (>= (cantidad_bateria ) (bateria_requerida_fotoslow)))
              (at start (>= (cantidad_bateria ) (umbral_bateria)))
      )

      :effect
        (and
              (at end (picture_taken ?l))
              (at end(decrease (cantidad_bateria )(bateria_requerida_fotoslow)))
              (at end(increase (bateria_usada )(bateria_requerida_fotoslow)))
        )
  )

  (:durative-action take_picture_fast
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 2)

    :condition
      (and
              (at start (at  ?l))
              (at start (not (moving )))
              (at start (not (picture_taken ?l)))
              (at start (>= (cantidad_bateria ) (bateria_requerida_fotofast)))
              (at start (>= (cantidad_bateria ) (umbral_bateria)))
      )

      :effect
        (and
              (at end (picture_taken ?l))
              (at end(decrease (cantidad_bateria )(bateria_requerida_fotofast)))
              (at end(increase (bateria_usada )(bateria_requerida_fotofast)))
        )
  )

  (:durative-action drill_slow
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 30)

    :condition
      (and
              (at start (at  ?l))
              (at start (not (moving )))
              (at start (not (drilled ?l)))
              (at start (>= (cantidad_bateria ) (bateria_requerida_drillslow)))
              (at start (>= (cantidad_bateria ) (umbral_bateria)))
      )

      :effect
        (and
              (at end (drilled ?l))
              (at end(decrease (cantidad_bateria )(bateria_requerida_drillslow)))
              (at end(increase (bateria_usada )(bateria_requerida_drillslow)))
        )
  )

  (:durative-action drill_fast
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 15)

    :condition
      (and
              (at start (at  ?l))
              (at start (not (moving )))
              (at start (not (drilled ?l)))
              (at start (>= (cantidad_bateria ) (bateria_requerida_drillfast)))
              (at start (>= (cantidad_bateria ) (umbral_bateria)))
      )

      :effect
        (and
              (at end (drilled ?l))
              (at end(decrease (cantidad_bateria )(bateria_requerida_drillfast)))
              (at end(increase (bateria_usada )(bateria_requerida_drillfast)))
        )
  )

  (:durative-action analyseSampleFromPlace_slow
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 20)

    :condition
      (and
              (at start (at  ?l))
              (at start (not (moving )))
              (at start (not (analysed ?l)))
              (at start (>= (cantidad_bateria ) (bateria_requerida_analyseslow)))
              (at start (>= (cantidad_bateria ) (umbral_bateria)))
      )

      :effect
        (and
              (at end (analysed ?l))
              (at end(decrease (cantidad_bateria )(bateria_requerida_analyseslow)))
              (at end(increase (bateria_usada )(bateria_requerida_analyseslow)))
        )
  )

  (:durative-action analyseSampleFromPlace_fast
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 10)

    :condition
      (and
              (at start (at  ?l))
              (at start (not (moving )))
              (at start (not (analysed ?l)))
              (at start (>= (cantidad_bateria ) (bateria_requerida_analysefast)))
              (at start (>= (cantidad_bateria ) (umbral_bateria)))
      )

      :effect
        (and
              (at end (analysed ?l))
              (at end(decrease (cantidad_bateria )(bateria_requerida_analysefast)))
              (at end(increase (bateria_usada )(bateria_requerida_analysefast)))
        )
  )

  (:durative-action communicate
    :parameters
      ()

    :duration
      (= ?duration 4)

    :condition
      (and
              (at start (not (moving )))
              (at start (>= (cantidad_bateria ) (bateria_requerida_communicate)))
              (at start (>= (cantidad_bateria ) (umbral_bateria)))
      )

      :effect
        (and
              (at end (communicated ))
              (at end(decrease (cantidad_bateria )(bateria_requerida_communicate)))
              (at end(increase (bateria_usada )(bateria_requerida_communicate)))
        )
  )

  (:durative-action recharge_rover
    :parameters
      ()

    :duration
      (= ?duration 70)

    :condition
              (at start (not (moving)))

    :effect
              (at end (assign(cantidad_bateria)100))
  )

)

(define (domain rover-domain)
    (:requirements :typing :durative-actions :fluents) ;requirements definition
    (:types location) ;types definition
    (:predicates ;predicates definition
        (at ?l - location)
        (accessible ?l1 ?l2 - location)
        (moving)
        (picture_taken ?l - location)
        (drilled ?l - location)
        (analysed ?l - location)
        (communicated)
	)
    (:functions ;function definition
        (cantidad_bateria)
        (bateria_usada)
        (bateria_requerida_moveslow ?l1 ?l2 - location) ;bateria requerida para moverse lento entre 2 sitios
        (bateria_requerida_movefast ?l1 ?l2 - location) ;bateria requerida para moverse lento entre 2 sitios
        (bateria_requerida_fotoslow) ;bateria requerida para tomar una foto lento
        (bateria_requerida_fotofast) ;bateria requerida para tomar una foto rapido
        (bateria_requerida_drillslow) ;bateria requerida para taladrar lento
        (bateria_requerida_drillfast) ;bateria requerida para taladrar rapido
        (bateria_requerida_analyseslow) ;bateria requerida para analizar lento
        (bateria_requerida_analysefast) ;bateria requerida para analizar rapido
        (bateria_requerida_communicate) ;bateria requerida para comunicarse con la estacion
        (umbral_bateria); nivel de beteria donde cuando se este por debajo el rover se debe poner a cargar
    )

    (:durative-action move_slow ;rover moves slow
        :parameters
            (?from - location
             ?to - location)

        :duration
            (= ?duration 5)

        :condition
	        (and
                (at start (not(moving)));el rover no se esta moviendo
                (at start (at ?from));esta en su posicion inicial
                (at start (accessible ?from ?to)); la meta es accesible desde el origen
                (at start (>= (cantidad_bateria ) (bateria_requerida_moveslow ?from ?to)));tienes bateria suficiente
                (at start (>= (cantidad_bateria ) (umbral_bateria))));tiene mas bateria que el umbral
        :effect
            (and
                (at start (moving ));al comienzo se mueve
                (at end (not(moving )));al final deja de moverse
                (at end (not (at  ?from))); al final pasa de estar en el origen
                (at end (at  ?to)) ;a estar en el destino
                (at end(decrease (cantidad_bateria )(bateria_requerida_moveslow ?from ?to)));decrece la bateria
                (at end(increase (bateria_usada )(bateria_requerida_moveslow ?from ?to)));incrementa la bateria usada
                )
	)

    (:durative-action move_fast ;rover moves fast
        :parameters
            (?from - location
             ?to - location)

        :duration
            (= ?duration 2)

        :condition
            (and
                (at start (not(moving)));el rover no se esta moviendo
                (at start (at ?from));esta en su posicion inicial
                (at start (accessible ?from ?to)); la meta es accesible desde el origen
                (at start (>= (cantidad_bateria ) (bateria_requerida_moveslow ?from ?to)));tienes bateria suficiente
                (at start (>= (cantidad_bateria ) (umbral_bateria))));tiene mas bateria que el umbral
        :effect
            (and
                (at start (moving ));al comienzo se mueve
                (at end (not(moving )));al final deja de moverse
                (at end (not (at  ?from))); al final pasa de estar en el origen
                (at end (at  ?to)) ;a estar en el destino
                (at end(decrease (cantidad_bateria )(bateria_requerida_moveslow ?from ?to)));decrece la bateria
                (at end(increase (bateria_usada )(bateria_requerida_moveslow ?from ?to)));incrementa la bateria usada
                )
    )

  (:durative-action take_picture_slow ;toma una foto en modo lento
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 2)

    :condition
      (and
              (at start (at  ?l));esta en el lugar
              (at start (not (moving )));no se esta moviendo
              (at start (not (picture_taken ?l)));no ha tomado la foto aun
              (at start (>= (cantidad_bateria ) (bateria_requerida_fotoslow)));tiene bateria suficiente
              (at start (>= (cantidad_bateria ) (umbral_bateria)));no ha bajado por debajo del umbral
      )

      :effect
        (and
              (at end (picture_taken ?l));se toma la foto
              (at end(decrease (cantidad_bateria )(bateria_requerida_fotoslow)));decrece la bateria
              (at end(increase (bateria_usada )(bateria_requerida_fotoslow)));incrementa la bateria usada
        )
  )

  (:durative-action take_picture_fast ;toma una foto en modo rapido
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 1)

    :condition
      (and
          (at start (at  ?l));esta en el lugar
          (at start (not (moving )));no se esta moviendo
          (at start (not (picture_taken ?l)));no ha tomado la foto aun
          (at start (>= (cantidad_bateria ) (bateria_requerida_fotoslow)));tiene bateria suficiente
          (at start (>= (cantidad_bateria ) (umbral_bateria)));no ha bajado por debajo del umbral
      )

      :effect
        (and
            (at end (picture_taken ?l));se toma la foto
            (at end(decrease (cantidad_bateria )(bateria_requerida_fotoslow)));decrece la bateria
            (at end(increase (bateria_usada )(bateria_requerida_fotoslow)));incrementa la bateria usada
        )
  )

  (:durative-action drill_slow ;taladrar en modo lento
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 30)

    :condition
      (and
          (at start (at  ?l));esta en el lugar
          (at start (not (moving )));no se esta moviendo
          (at start (not (drilled ?l)));no ha taladrado aun
          (at start (>= (cantidad_bateria ) (bateria_requerida_fotoslow)));tiene bateria suficiente
          (at start (>= (cantidad_bateria ) (umbral_bateria)));no ha bajado por debajo del umbral
      )

      :effect
        (and
              (at end (drilled ?l));se taladra el sitio
              (at end(decrease (cantidad_bateria )(bateria_requerida_fotoslow)));decrece la bateria
              (at end(increase (bateria_usada )(bateria_requerida_fotoslow)));incrementa la bateria usada
        )
  )

  (:durative-action drill_fast ;taladrar en modo lento
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 15)

      :condition
        (and
            (at start (at  ?l));esta en el lugar
            (at start (not (moving )));no se esta moviendo
            (at start (not (drilled ?l)));no ha taladrado aun
            (at start (>= (cantidad_bateria ) (bateria_requerida_fotoslow)));tiene bateria suficiente
            (at start (>= (cantidad_bateria ) (umbral_bateria)));no ha bajado por debajo del umbral
        )

        :effect
          (and
                (at end (drilled ?l));se taladra el sitio
                (at end(decrease (cantidad_bateria )(bateria_requerida_fotoslow)));decrece la bateria
                (at end(increase (bateria_usada )(bateria_requerida_fotoslow)));incrementa la bateria usada
          )
  )

  (:durative-action analyseSampleFromPlace_slow ;analiza la muestra de un sitio en modo lento
    :parameters
      (
      ?l - location)

    :duration
      (= ?duration 20)

      (and
          (at start (at  ?l));esta en el lugar
          (at start (not (moving )));no se esta moviendo
          (at start (not (analysed ?l)));no ha tomado la muestra aun
          (at start (>= (cantidad_bateria ) (bateria_requerida_fotoslow)));tiene bateria suficiente
          (at start (>= (cantidad_bateria ) (umbral_bateria)));no ha bajado por debajo del umbral
      )

      :effect
        (and
              (at end (analysed ?l));se analiza la muestra del sitio
              (at end(decrease (cantidad_bateria )(bateria_requerida_fotoslow)));decrece la bateria
              (at end(increase (bateria_usada )(bateria_requerida_fotoslow)));incrementa la bateria usada
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
            (at start (at  ?l));esta en el lugar
            (at start (not (moving )));no se esta moviendo
            (at start (not (analysed ?l)));no ha tomado la muestra aun
            (at start (>= (cantidad_bateria ) (bateria_requerida_fotoslow)));tiene bateria suficiente
            (at start (>= (cantidad_bateria ) (umbral_bateria)));no ha bajado por debajo del umbral
        )

    :effect
          (and
                (at end (analysed ?l));se analiza la muestra del sitio
                (at end(decrease (cantidad_bateria )(bateria_requerida_fotoslow)));decrece la bateria
                (at end(increase (bateria_usada )(bateria_requerida_fotoslow)));incrementa la bateria usada
          )
  )

  (:durative-action communicate
    :parameters
      ()

    :duration
      (= ?duration 4)

    :condition
      (and
              (at start (not (moving )));no se esta moviendo
              (at start (>= (cantidad_bateria ) (bateria_requerida_communicate)));tiene bateria suficiente
              (at start (>= (cantidad_bateria ) (umbral_bateria)));no ha bajado por debajo del umbral
      )

      :effect
        (and
              (at end (communicated ));se comunica
              (at end(decrease (cantidad_bateria )(bateria_requerida_communicate)));decrece la bateria
              (at end(increase (bateria_usada )(bateria_requerida_communicate)));incrementa la bateria usada
        )
  )

  (:durative-action recharge_rover ;se recarga el rover
    :parameters
      ()

    :duration
      (= ?duration 70)

    :condition
              (at start (not (moving)));el rover no se esta moviendo

    :effect
              (at end (assign(cantidad_bateria)100)) ;se carga al 100
  )

)

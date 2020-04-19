(define
    (problem rover)
    (:domain rover-domain)
    (:objects ;declaracion de objetos
        lugar1 lugar2 lugar3 lugar4 - location
    )
    (:init
        (at lugar1);el rover esta en el lugar1
        (= (cantidad_bateria ) 100)
        (accessible  lugar1 lugar2);declaracion de la accesibilidad entre dos sitios
        (accessible  lugar1 lugar3)
        (accessible  lugar2 lugar4)
        (accessible lugar3 lugar4)
        (= (bateria_requerida_fotoslow) 3);declaracion de la bateria requerida para realizar distintas acciones
        (= (bateria_requerida_fotofast) 6)
        (= (bateria_requerida_drillslow) 20)
        (= (bateria_requerida_drillfast) 40)
        (= (bateria_requerida_analyseslow) 2)
        (= (bateria_requerida_analysefast) 4)
        (= (bateria_requerida_communicate) 1)
        (= (bateria_requerida_moveslow lugar1 lugar2) 30)
        (= (bateria_requerida_moveslow lugar1 lugar3) 25)
        (= (bateria_requerida_moveslow lugar2 lugar4) 15)
        (= (bateria_requerida_moveslow lugar3 lugar4) 15)
        (= (bateria_requerida_movefast lugar1 lugar2) 60)
        (= (bateria_requerida_movefast lugar1 lugar3) 50)
        (= (bateria_requerida_movefast lugar2 lugar4) 30)
        (= (bateria_requerida_movefast lugar3 lugar4) 30)
        (= (umbral_bateria) 20);declaracion del umbral de bateria

        (=(bateria_usada)0);declaracion de la bateria usada
    )
    (:goal (and ;declaracion de la meta
              (analysed lugar3)
              (picture_taken lugar3)
              (drilled lugar4)
              (drilled lugar3)
              (analysed lugar4)
              (analysed lugar1)
              (communicated)
            )
    )

    (:metric minimize (bateria_usada))
)

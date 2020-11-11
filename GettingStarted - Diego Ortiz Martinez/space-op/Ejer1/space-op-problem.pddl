(define (problem spaceops-problem)
   (:domain spaceops)
   (:objects nowhere DirStar1 DirPhenomenon2 DirStar3 DirPhenomenon4 DirStar5 DirPhenomenon6 -direction; declaracion de objetos
            Satellite1 - satellite
            Mode_thermograph0 - mode
            tempsensor - instrument
            
   )
   (:init   (on_board tempsensor Satellite1);situacion inicial
            (supports tempsensor Mode_thermograph0)
            (pointing Satellite1 nowhere)
    )
   
   
   (:goal (and  (have_image DirPhenomenon4 Mode_thermograph0); situacion meta
                (have_image DirStar5 Mode_thermograph0)
                (have_image DirPhenomenon6 Mode_thermograph0)
            )
    )
    )
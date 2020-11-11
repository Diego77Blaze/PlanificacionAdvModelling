(define (problem spaceops-problem)
   (:domain spaceops)
   (:objects nowhere star0 star1 phenomenon2 phenomenon3 star3 phenomenon4 star5 phenomenon6  - direction;declaracion de objetos
            Satellite1 - satellite
            Mode_thermograph0 Spectrograph2 - mode
            Instrument1 - instrument
            
   )
   (:init   (on_board Instrument1 Satellite1);situacion inicial
            (supports Instrument1 Mode_thermograph0)
            (supports Instrument1 Spectrograph2)
            (pointing Satellite1 phenomenon3)
    )
   
   
   (:goal (have_image star0 Spectrograph2);situacion meta
    )
    )
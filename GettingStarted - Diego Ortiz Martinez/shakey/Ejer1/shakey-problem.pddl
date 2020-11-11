(define (problem shakey-problem)
   (:domain shakey)
   (:objects room1 room2 room3 room4 room5 - room;declaracion de objetos
            box1 box2 - box
            
   )
   (:init   (shakey_in room1);situacion inicial
            (box_in box1 room1)
            (box_in box2 room1)
            (room_pasillo room5)
            (on_floor)
    ) 
   (:goal (and  (lights_on room1);situacion final  = encender todas las luces 
                (lights_on room2)  
                (lights_on room3)  
                (lights_on room4)  
                (lights_on room5)
            )
    )
)
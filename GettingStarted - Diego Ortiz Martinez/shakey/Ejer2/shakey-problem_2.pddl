(define (problem shakey-problem)
   (:domain shakey)
   (:objects room1 room2 room3 room4 room5 room6 room7 room8 room9 - room;declaracion de objetos
            box1 box2 box3 - box
            
   )
   (:init   (shakey_in room2);situacion inicial
            (connected_room room1 room5);se especifica qué habitaciones están conectadas
            (connected_room room2 room5)
            (connected_room room3 room5)
            (connected_room room4 room5)
            (connected_room room6 room5)
            (connected_room room7 room5)
            (connected_room room3 room8)
            (connected_room room8 room9)
            (box_in box1 room1);se especifica en qué habitaciones hay cajas
            (box_in box2 room5)
            (box_in box3 room2)
            (on_floor)
            
    )
   
   
   (:goal (and  (lights_on room1) ;situacion final = encender todas las luces 
                (lights_on room2)  
                (lights_on room3)  
                (lights_on room4)  
                (lights_on room5)
                (lights_on room6)
                (lights_on room7)
                (lights_on room8)
                (lights_on room9)
            )
    )
)
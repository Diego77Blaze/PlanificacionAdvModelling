(define (problem blocksproblem)
   (:domain blocks)
   (:objects C D E F B I J A N O K M P H G L Q - pieza;declaracion de objetos
   )
   (:init  (ontable A) (ontable B) (ontable C) (ontable D) (ontable E) ;estado incial 
            (ontable F) (ontable G) (ontable H) (ontable I) (ontable J) (ontable K) 
            (ontable L) (ontable M) (ontable N) (ontable O) (ontable P) (ontable Q)
   				 (clear A) (clear C) (clear B) (clear D) (clear E) (clear F) (clear G)  
   				 (clear H) (clear I) (clear J) (clear K) (clear L) (clear M) (clear N) 
   				 (clear O) (clear P) (clear Q)
           (handempty)
          
   )
   (:goal (and (on Q N) (on N L) (on L O) (on O J) (on J H) (on H C) (on C E);estado final
     (on E M) (on M P) (on P A) (on A G) (on G B) (on B I) (on I K)
     (on K F) (on F D))
   )
)
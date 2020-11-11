(define (problem problem-blocks)
   (:domain blocks)
   (:objects piezaa piezab piezac - pieza);declaracion de objetos
   (:init      (clear piezac);estado incial
   			   (clear piezab)
               (clear piezaa)
   			   (ontable piezaa)
   			   (ontable piezab)
               (ontable piezac)
               (handempty)
   )
   (:goal (and (handempty);estado final
   			   (ontable piezac)
               (on piezab piezac)
               (on piezaa piezab)
          )
   )
)


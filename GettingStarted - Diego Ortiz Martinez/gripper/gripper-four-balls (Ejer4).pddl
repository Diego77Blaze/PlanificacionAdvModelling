(define (problem gripper-four-balls)
   (:domain gripper); tengo que decir a que dominio pertenece
   (:objects cocina salon - room;definimos los objetos usados en la planificacion del problema
             Z1 Z2 - ball
             left right)
   (:init ;(ROOM rooma)          (ROOM roomb);definimos el estado inicial del problema
          ;(BALL Z1)          (BALL Z2)
          (GRIPPER left)        (GRIPPER right)
          (at-robby cocina)
          (free left)          (free right)
          (at-ball Z1 cocina)  (at-ball Z2 cocina)
   )
   (:goal (and (at-ball Z1 salon);definimos el estado meta del problema
               (at-ball Z2 salon)
               (at-robby salon)
          )
   )
)

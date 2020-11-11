(define (problem gripper-four-balls)
   (:domain gripper); tengo que decir a que dominio pertenece
   (:objects rooma roomb;definimos los objetos usados en la planificacion del problema
             ball1 ball2 ball3 ball4 ball5 ball6
             left right)
   (:init (ROOM rooma)          (ROOM roomb);definimos el estado inicial del problema
          (BALL ball1)          (BALL ball2)
          (BALL ball3)          (BALL ball4)
          (BALL ball5)          (BALL ball6)
          (GRIPPER left)        (GRIPPER right)
          (at-robby roomb)
          (free left)          (free right)
          (at-ball ball1 rooma)  (at-ball ball2 rooma)
          (at-ball ball3 roomb)  (at-ball ball4 roomb)
          (at-ball ball5 roomb)  (at-ball ball6 roomb)
   )
   (:goal (and (at-ball ball1 rooma);definimos el estado meta del problema
               (at-ball ball2 rooma)
               (at-ball ball3 rooma)
               (at-ball ball4 rooma)
               (at-ball ball5 rooma)
               (at-ball ball6 roomb)
          )
   )
)
(define (domain spaceops)
    (:requirements :strips :typing :equality)
    (:types satellite direction instrument mode) ;declaracion de tipos
    (:predicates ;predicados
        (on_board ?i ?s)
        (supports ?i ?m)
        (maintenance ?s)
        (power_on ?s)
        (calibrated ?i)
        (pointing ?s ?d)
        (have_image ?d ?m)
    )
(:action turn;accion de girar
  :parameters (?s - satellite ?d2 ?d1 - direction)
  :precondition (and (not(= ?d1 ?d2))
                     (pointing ?s ?d1); apunta al primero
                     (not(pointing ?s ?d2)); no apunta al segundo
                     )
  :effect (and(pointing ?s ?d2); se quiere apuntar al segundo y no al primero
          (not(pointing ?s ?d1))
          )
)
 
(:action switch_on ;accion de encender
    :parameters (?i - instrument ?s - satellite)
    :precondition (and (not(power_on ?i)); instrumento esta apagado
                        (on_board ?i ?s)); el instrumento esta en el satelite
    :effect (power_on ?i); se enciende el instrumento
)

(:action switch_off;accion de apagar
    :parameters (?i - instrument ?s - satellite)
    :precondition (and (power_on ?i); esta encendido el instrumento
                    (on_board ?i ?s)) ;el instrumento esta en el satelite
    :effect (not(power_on ?i))); se apaga el instrumento


(:action perform_maintenance ;accion de hacer el mantenimiento
    :parameters (?s - satellite)
    :precondition(not(maintenance ?s)); no se ha hecho el mantenimiento
    :effect (maintenance ?s) ; se hace el mantenimiento
)

(:action calibrate;accion de calibrar
    :parameters (?s - satellite ?i - instrument ?d - direction)
    :precondition (and (power_on ?i); el instrumento esta encendido
                       (on_board ?i ?s); tambien esta a bordo
                       (not(calibrated ?i)); no esta calibrado
                       (pointing ?s ?d)); y esta apuntando a la direccion adecuada
    :effect (calibrated ?i);se calibra el instrumento
)
(:action take_image;accion de tomar foto
  :parameters (?s - satellite ?d - direction ?i - instrument ?m - mode)
  :precondition (and (calibrated ?i); el instrumento esta calibrado
                     (on_board ?i ?s); esta a bordo
                     (supports ?i ?m); el instrumento soporta el modo
                     (power_on ?i); esta encendido 
                     (pointing ?s ?d);esta apuntando
                     (maintenance ?s)); se ha hecho el mantenimiento
  :effect (and (have_image ?d ?m) ;se hace una imagen
               (not (maintenance ?s))));habría que volver a hacer mantenimiento
)
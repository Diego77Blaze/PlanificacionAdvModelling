(define (domain pizza)
  (:requirements :typing :equality :durative-actions :fluents :negative-preconditions)
  (:types
        location - object
            casa local - location
            pedido - object
            pizza plato - pedido
            moto - object
  )

(:predicates
    (at ?l - location ?m - moto)
    (amasada ?p - pizza)
    (con_ingredientes ?s - pizza)
    (cocinado ?p - pedido)
    (cargado ?p - pedido)
    (entregado ?p - pedido ?l - location)
)

(:functions
    (cantidad_gasolina)
    (gasolina_requerida ?l1 ?l2 - location)
    (capacidad_moto ?m - moto)
    (carga_actual ?m - moto)
    (distancia ?from ?to - location)
    (umbral_gasolina)
)

(:durative-action amasar
  :parameters (?p - pizza)
  :duration (= ?duration 3)
  :condition (at start (not (amasada ?p)))
  :effect (at end (amasada ?p))
 )

(:durative-action echar_ingredientes
:parameters (?p - pizza)
:duration (= ?duration 1)
:condition (at start (not (con_ingredientes ?p)))
:effect (at end (con_ingredientes ?p))
)

(:durative-action hornear
:parameters (?p - pizza)
:duration (= ?duration 5)
:condition (and
              (at start (amasada ?p))
              (at start (con_ingredientes ?p))
              ;(at start (not (cocinado ?p)))
            )
    :effect (at end (cocinado ?p))
   )

(:durative-action cocinar
 :parameters (?s - plato)
 :duration (= ?duration 5)
 :condition (at start (not (cocinado ?s)))
 :effect (at end (cocinado ?s))
)

(:durative-action llenar_moto
  :parameters (?p - pedido ?m - moto ?l - local)
  :duration (= ?duration 1)
  :condition (and
                (at start (cocinado ?p))
                (at start (at ?l ?m))
                (at start (< (carga_actual ?m) (capacidad_moto ?m))))
  :effect (and
                (at end (cargado ?p))
                (at end (increase (carga_actual ?m) 1)))
)

(:durative-action desplazarse
  :parameters (?m - moto ?from - location ?to - location)
  :duration (= ?duration (*(distancia ?from ?to) 2))
  :condition (and
                (at start (at ?from ?m))
                (at start (not (= ?from ?to)))
                ;(at start (not (at ?to ?m)))
                (at start (> (cantidad_gasolina) (gasolina_requerida ?from ?to)))
                (at start (> (cantidad_gasolina) (umbral_gasolina)))
                )
  :effect (and
                (at end (at ?to ?m))
                (at end (not (at ?from ?m)))
                (at end (decrease (cantidad_gasolina) (gasolina_requerida ?from ?to)))
          )
)

(:durative-action entregar_pedido
  :parameters (?p - pedido ?m - moto ?to - location)
  :duration (= ?duration 1)
  :condition (and
                (at start (at ?to ?m))
                (at start (cargado ?p))
                ;(at start (not (entregado ?p ?to)))
                )
  :effect (and
                (at end (not(cargado ?p)))
                (at end (entregado ?p ?to))
                (at end (decrease (carga_actual ?m) 1)))
)
 ;repostar con umbral de gasolina

 (:durative-action repostar
   :parameters (?p - pedido ?m - moto ?gasolinera - location)
   :duration (= ?duration 2)
   :condition (and
                 (at start (at ?gasolinera ?m))
                 (at start (< (cantidad_gasolina) 20))
                 )
   :effect (at end(assign cantidad_gasolina 100))
 )
)

(define (domain pizza)
  (:requirements :typing :durative-actions)
  (:types
   	        location - object
            casa local - location
            pedido - object
            pizza plato - pedido
            moto - object

  )

(:predicates
    at ?l - location ?m - moto
    amasada ?p - pizza
    con_ingredientes ?s - plato
    cocinado ?p - pedido
    cargado ?p - pedido
    entregado ?p - pedido ?l - location

)

(:functions
    (cantidad_gasolina)
    (gasolina_requerida ?l1 ?l2 - location)
    (capacidad_moto ?m - moto)
    (carga_actual ?m - moto)
    (distancia ?from ?to - location)
)

(:durative-action amasar
  :parameters (?p - pizza)
  :duration (= ?duration 3)
  :condition (
                (at start (not (amasada ?p))))
  :effect (
                (at end (amasada ?p)))
 )

(:durative-action echar_ingredientes
:parameters (?p - pizza)
:duration (= ?duration 1)
:condition (
             (at start (not (con_ingredientes ?p))))
:effect (
             (at end (con_ingredientes ?p)))
)

(:durative-action hornear
:parameters (?p - pizza)
:duration (= ?duration 5)
:condition (and
              (at start (amasada ?p))
              (at start (con_ingredientes ?p))
              (at start (not (cocinado ?p))))
    :effect (
                  (at end (cocinado ?p)))
   )

(:durative-action cocinar
 :parameters (?s - plato)
 :duration (= ?duration 5)
 :condition (
               (at start (not (cocinado ?s))))
 :effect (
               (at end (cocinado ?s)))
)

(:durative-action llenar_moto
  :parameters (?p - pedido ?m - moto)
  :duration (= ?duration 1)
  :condition (and
                (at start (cocinado ?p))
                (at start (not (cargado ?p)))
                (at start (< (carga_actual ?m) (capacidad_moto ?m))))
  :effect (and
                (at end (cargado ?p))
                (at end (increment (carga_actual) 1)))
)

(:durative-action entregar_pedido
  :parameters (?p - pedido ?m - moto ?from - location ?to - location)
  :duration (= ?duration (/(distance ?from ?to)(speed ?mode)))
  :condition (and
                (at start (at ?from ?m))
                (at start (not (at ?to ?m)))
                (at start (cargado ?p))
                (at start (not (entregado ?p ?to)))
                )
  :effect (
                (at end (at ?to ?m))
                (at end (not (at ?from ?m)))
                (at end (not(cargado ?p)))
                (at end (entregado ?p ?to))
                (at end (decrement (carga_actual) 1)))
)
 ;repostar con umbral de gasolina

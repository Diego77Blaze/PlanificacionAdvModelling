;En este dominio nos encontramos una pequeña pizzería que acaba de abrir y que cuenta solamente con una moto para llevar a cabo sus pedidos.
;En esta pizzería se venderán tanto pizzas como otro tipo de platos que tendrán un tiempo y proceso de cocinado distinto a las primeras:
;    -Las pizzas se amasarán, se echarán ingredientes y hornearán
;    -El resto de platos se cocinarán
;Estos pedidos se entregarán en la moto, que tiene una capacidad limitada, a parte de un nivel de gasolina que se irá gastando según se entreguen estos pedidos.
;En el caso de que la moto empezara a tener un menos del 20% de su gasolina siendo 100 el maximo, tendrá que parar a repostar en una gasolinera cercana.

(define (domain pizza)
  (:requirements :typing :equality :durative-actions :fluents :negative-preconditions) ;definicion de los requisitos
  (:types ;definicion de los tipos
            location - object
            casa local gasolinera - location
            pedido - object
            pizza plato - pedido
            moto - object
  )

(:predicates ;definicion de los predicados
    (at ?l - location ?m - moto) ;marca donde se encuentra la moto
    (amasada ?p - pizza) ;valor que indica si la pizza está amasada
    (con_ingredientes ?s - pizza) ;si está amasada, tendrán que echarse los ingredientes
    (cocinado ?p - pedido) ;indica si un pedido está cocinado del todo y listo para entregar
    (cargado ?p - pedido) ;indica si un pedido está cargado en la moto
    (entregado ?p - pedido ?l - location) ;indica si un pedido ha sido entregado en su respectiva casa
)

(:functions ;declaracion de funciones
    (cantidad_gasolina) ;indica la cantaidad de gasolina actual en la moto
    (gasolina_requerida ?l1 ?l2 - location) ;indica la gasolina requerida entre dos localizaciones
    (capacidad_moto ?m - moto) ;indica la capacidad de la moto
    (carga_actual ?m - moto) ;indica la carga actual de la moto
    (distancia ?from ?to - location) ;indica la distancia entre dos localizaciones
    (umbral_gasolina) ;indica el umbral del gasolina que marca cuando se debe parar a repostar
)

(:durative-action amasar ;accion de amasar la masa
  :parameters (?p - pizza)
  :duration (= ?duration 3)
  :condition (at start (not (amasada ?p))) ;al comienzo no está amasada
  :effect (at end (amasada ?p));al final se amasa
 )

(:durative-action echar_ingredientes
:parameters (?p - pizza)
:duration (= ?duration 1)
:condition (at start (not (con_ingredientes ?p)));al comienzo no tiene los ingredientes aún
:effect (at end (con_ingredientes ?p));al final los tiene
)

(:durative-action hornear
:parameters (?p - pizza)
:duration (= ?duration 5)
:condition (and
              (at start (amasada ?p));al comienzo debe estar amasada
              (at start (con_ingredientes ?p));y con ingredientes
              ;(at start (not (cocinado ?p)));pero no cocinada aún
            )
    :effect (at end (cocinado ?p));al final debe estar cocinada
   )

(:durative-action cocinar
 :parameters (?s - plato)
 :duration (= ?duration 5)
 :condition (at start (not (cocinado ?s)));al comienzo no debe estar cocinada
 :effect (at end (cocinado ?s));pero al final sí
)

(:durative-action llenar_moto
  :parameters (?p - pedido ?m - moto ?l - local)
  :duration (= ?duration 1)
  :condition (and
                (at start (cocinado ?p));para cargar un plato debe estar cocinado
                (at start (at ?l ?m));la moto debe cargar las cosas en el local
                (at start (< (carga_actual ?m) (capacidad_moto ?m))));debe haber capacidad suficiente en la moto aún
  :effect (and
                (at end (cargado ?p));se carga el pedido
                (at end (increase (carga_actual ?m) 1)));se incrementa en uno la carga actual de la moto
)

(:durative-action desplazarse
  :parameters (?m - moto ?from - location ?to - location)
  :duration (= ?duration (*(distancia ?from ?to) 2))
  :condition (and
                (at start (at ?from ?m));se está en el inicio
                (at start (not (= ?from ?to)));no es la misma localización el comienzo que el final
                (at start (> (cantidad_gasolina) (gasolina_requerida ?from ?to)));debe tener gasolina suficiente para llegar al destino
                (at start (> (cantidad_gasolina) (umbral_gasolina)));para desplazarse debe tener mas de un 20% de gasolina si contamos que cuenta con un 100%
                )
  :effect (and
                (at end (at ?to ?m));se moverá al destino
                (at end (not(at ?from ?m)))
                (at end (decrease (cantidad_gasolina) (gasolina_requerida ?from ?to)));la cantidad de gasolina decrece lo requerido
          )
)

(:durative-action entregar_pedido
  :parameters (?p - pedido ?m - moto ?to - casa)
  :duration (= ?duration 1)
  :condition (and
                (at start (at ?to ?m));se encuentra en punto de reparto
                (at start (cargado ?p));está cargado con el pedido
                )
  :effect (and
                (at end (not(cargado ?p)));deja de estar cargado
                (at end (entregado ?p ?to));porque pasa a estar entregado
                (at end (decrease (carga_actual ?m) 1)));decrece la carga actual de la moto
)

 (:durative-action repostar
   :parameters (?p - pedido ?m - moto ?gasolinera - gasolinera)
   :duration (= ?duration 2)
   :condition (and
                 (at start (at ?gasolinera ?m));tiene que estar en la gasolinera
                 (at start (< (cantidad_gasolina) 20));tiene que tener menos del 20% de su gasolina
                 )
   :effect (at end(assign cantidad_gasolina 100));reposta hasta el 100%
 )
)

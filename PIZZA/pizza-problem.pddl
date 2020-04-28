(define (problem pizzaproblem)
(:domain pizza)

(:objects ;object declaration ;definicion de objetos necesarios
    pizzeria - local
    gas_station - gasolinera
    casa1 casa2 casa3 - casa
    lasagna macarrones - plato
    pizza1 - pizza
    moto1 - moto
)

(:init


    (= (cantidad_gasolina) 100);cantidad de gasolina de la moto repartidora

    (= (gasolina_requerida pizzeria casa1) 20) ;definicion de la gasolina que se gastaría dependiendo del tramo
    (= (gasolina_requerida pizzeria casa2) 25)
    (= (gasolina_requerida pizzeria casa3) 30)
    (= (gasolina_requerida  casa1 pizzeria) 20)
    (= (gasolina_requerida casa1 casa2) 20)
    (= (gasolina_requerida pizzeria casa3) 15)
    (= (gasolina_requerida casa2 casa3) 2)

    (= (distancia pizzeria casa1) 20) ;definicion de la distancia entre dos localizaciones
    (= (distancia pizzeria casa2) 25)
    (= (distancia pizzeria casa3) 30)
    (= (distancia casa1 casa2) 20)
    (= (distancia casa1 casa3) 15)
    (= (distancia casa1 pizzeria) 20)
    (= (distancia casa2 casa3) 2)
    (= (distancia casa2 casa1) 20)
    (= (distancia casa1 pizzeria) 20)

    (= (umbral_gasolina) 20) ;definicion del umbral de gasolina con el que debería ir a repostar como mínimo


    (at pizzeria moto1) ;definición de dónde se encuentra la moto inicialmente

    (= (capacidad_moto moto1) 2) ;definición de la capacidad máxima de la moto

    (= (carga_actual moto1) 0) ;definición de la carga inicial de la moto

)

(:goal ;goal declaration
(and
    (entregado pizza1 casa1) ;los pedidos deben estar entregados en sus respectivas casas
    (entregado lasagna casa2)
    (entregado macarrones casa3)
))

(:metric minimize (total-time)) ;metric declaration

)

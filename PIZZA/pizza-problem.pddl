(define (problem pizzaproblem)
(:domain pizza)

(:objects ;object declaration
    pizzeria - local
    casa1 casa2 casa3 - casa
    lasagna macarrones - plato
    pizza1 - pizza
    moto1 - moto
)

(:init
    (at pizzeria moto1)

    (= (cantidad_gasolina) 100)

    (= (gasolina_requerida pizzeria casa1) 20) (= (gasolina_requerida pizzeria casa2) 25) (= (gasolina_requerida pizzeria casa3) 30)
    (= (gasolina_requerida casa1 casa2) 20) (= (gasolina_requerida pizzeria casa3) 15)
    (= (gasolina_requerida casa2 casa3) 2)

    (= (capacidad_moto moto1) 3)

    (= (carga_actual moto1) 0)


    (= (distancia pizzeria casa1) 20) (= (distancia pizzeria casa2) 25) (= (distancia pizzeria casa3) 30)
    (= (distancia casa1 casa2) 20) (= (distancia pizzeria casa3) 15)
    (= (distancia casa2 casa3) 2)


)

(:goal ;goal declaration
(and
    (entregado pizza1 casa1)
    (entregado lasagna casa2)
    (entregado macarrones casa3)
))

(:metric minimize (total-time)) ;metric declaration

)

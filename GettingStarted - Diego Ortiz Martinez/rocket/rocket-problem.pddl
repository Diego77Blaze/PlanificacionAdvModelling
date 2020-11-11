(define (problem rocket-problem)
   (:domain rocket)
   (:objects    AtlasV DeltaII Pegasus Taurus ApolloXI Lancer - rocket;declaracion de objetos
				earth mars - place
   				Human1 Human2 Human3 - human
                Cargo1 Cargo2 Cargo3 - cargo
                
   )
   (:init 	;declaracion de situacion inicial
			(has_fuel AtlasV)
    		(has_fuel DeltaII)
    		(has_fuel Pegasus)
    		(has_fuel Taurus)
    		(has_fuel ApolloXI)
    		(has_fuel Lancer)
    	    (empty AtlasV)
    		(empty DeltaII)		
    		(empty Pegasus)
    		(empty Taurus)
    		(empty ApolloXI)
    		(empty Lancer)
   			(rocket_at AtlasV earth)
    	    (rocket_at DeltaII earth)
    		(rocket_at Pegasus earth)
    		(rocket_at Taurus earth)
    		(rocket_at ApolloXI earth)
    		(rocket_at Lancer earth)

    )
   
   
   (:goal (and  (unloaded_rocket AtlasV mars);declaracion de situacion meta en las que los cohetes se llenarán aleatoriamente
           		(unloaded_rocket DeltaII mars) ;el viaje termina cuando se descarga el cohete
           		(unloaded_rocket Pegasus mars)
           		(unloaded_rocket Taurus mars)
           		(unloaded_rocket ApolloXI mars)
           		(unloaded_rocket Lancer mars)
            )
    )
)

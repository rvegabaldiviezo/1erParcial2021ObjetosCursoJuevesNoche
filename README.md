* Ejercicio 1: Parcial - OBJETOS - JUEVES - NOCHE -2021  

Nos piden modelar un software de inventariado para una importante galería de arte local
para ayudarlos con el registro del valor, estado y reparación de sus obras.

La colección de la galería cuenta con diversas obras de las cuales conocemos su autor, el año 
en que fueron creadas y el estado de deterioro en el que se encuentran. Actualmente la galería 
dispone de diversos tipos de obra: Pinturas de todas las épocas, Esculturas de diversos materiales 
y tamaños e Intervenciones, que consisten en alterar artísticamente algún objeto común (zapatillas, 
frascos, peines, etc.) o incluso otra obra.

Implementar un modelo basado en el Paradigma Orientado a Objetos que modele este dominio 
y permita realizar las consultas/operaciones descritas a continuación:

1) Conocer el valor de una obra:    obra.valor(): number

El valor de una obra está determinado por múltiples factores, que incluyen su tipo, 
su estado de deterioro y el renombre de su autor.

El valor de las pinturas depende de su atractivo (un valor arbitrario que varía 
para cada pintura) el cual se multiplica por un índice que depende del período 
durante el cual fueron creadas: Aquellas pinturas creadas durante el 
Renacimiento Europeo (1350 - 1527) multiplican su atractivo por 7, 
las creadas durante la edad media (476 - 1349) lo multiplican por 3 
y todas las demás por 1.

El valor de las esculturas se calcula multiplicando el valor de su material por 
su volumen aproximado (es decir, su largo * ancho * alto).

Las intervenciones valen $10000 más que el objeto u obra intervenida.

Independientemente del tipo, toda obra creada por un autor famoso vale 10 veces más.

Lamentablemente, no todas las obras de la galería se conservan en buenas condiciones y 
esto, por supuesto afecta a su precio:

El valor de las obras Deterioradas disminuye en $1 por cada 10 puntos de deterioro,
hasta un máximo de la mitad de su valor original.

Las obras Arruinadas sufrieron demasiado el paso del tiempo y están más allá de todo 
intento de restauración. Su valor es siempre $0.

Las obras Sanas no ven su valor afectado.

* 2) Restaurar una obra: obra.restaurar(presupuestoDisponible)

Dada una obra y un valor numérico representante del presupuesto disponible, 
realizar un proceso de restauración:

Las obras Deterioradas comparan su costo de restauración ($1000 por cada 
punto de deterioro) con el presupuesto disponible. Si el presupuesto cubre 
el costo, la obra deja de estar deteriorada y pasa a estar Sana. Si, por el 
contrario, el presupuesto se quedó corto, la obra pasa a estar Arruinada.

Las obras Sanas no se ven afectadas por el proceso de restauración y quedan igual.

Las obras Arruinadas NO PUEDEN ser restauradas e intentarlo constituye un error.

* 3) Consultas a la Galería

Agregar al modelo un nuevo objeto que represente a la Galería, la cual contiene 
el conjunto de las obras que posee y una interfaz adecuada para responder 
a las siguientes consultas:

    a) Dado un año de inicio y uno de fin, listar los nombre de los 
    autores de obras creadas en dicho período (sin repetidos).
    
    b) Dado un autor, indicar el valor total de las obras de dicho autor.
    
    c) Indicar la obra más cara que se encuentre en exposición. Considerar 
    que la galería sólo expone las obras sanas y las obras deterioradas 
    con menos de 30 puntos de deterioro que valgan menos de $100,000.

* 4) Frescos

Aparece un nuevo tipo de obra: los Frescos. Estas obras son pinturas realizadas directamente
sobre el yeso (fresco) de una pared, lo cual las hace más frágiles, pero también 
más costosas, que otras pinturas.

Los frescos valen 10% más que las pinturas comunes (antes de considerar su autor o deterioro), 
pero el presupuesto para restaurarlas rinde 20% menos.
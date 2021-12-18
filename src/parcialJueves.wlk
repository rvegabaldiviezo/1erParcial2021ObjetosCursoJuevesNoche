import ObjetosAux.*

/* Consultas/operaciones requeridas:
 * 
 * 1) obra.valor() //obra: pintura, escultura, intervencion
 * 
 * 2) obra.restaurar(presupuestoDisponible) //obra: pintura, escultura, intervencion
 * 
 * 3) 
 * 	3.a) galeria.autoresDelPeriodo(anioInicio,anioFin) 
 * 	3.b) galeria.valorTotalADeLasObras(autor)
 * 	3.c) galeria.obraMasCaraEnExposicion()
 * 
 * 4) 
 * 	obra.valor // obra: fresco
 * 	obra.restaurar() //obra: fresco	
*/

class RestaurarException inherits Exception { }

class Obra{
    const autor // Ej: miguelAngel
    const property anioDeCreacion  // Ej: 476
    var property estadoDeDeterioro // Ej: deteriorada || arruinada || sana
    
    method factorPorFama() = if(autor.famoso()) 10 else 1
    
    method valorInicialDeObra() =  0
    
    method valor() = estadoDeDeterioro.valor(self.valorInicialDeObra()* self.factorPorFama())
    
    method restaurar(presupuestoDisponible){ 
    	estadoDeDeterioro.restaurar(self, presupuestoDisponible)
    }    
}

class Pintura inherits Obra{
    const atractivo

    method indice() =  if(anioDeCreacion.between(476,1349)) 3 else if(anioDeCreacion.between(1350,1527)) 7 else 1
	
	override method valorInicialDeObra() =  atractivo * self.indice()
}


class Fresco inherits Pintura{		
	override method valorInicialDeObra() =  1.1 * atractivo * self.indice()
	
	override method restaurar(presupuestoDisponible){ super(presupuestoDisponible*0.8)}	
}

class Escultura inherits Obra{
    const material  //Ej: marmol
    const largo
    const ancho 
    const alto

    method volumen() = largo * ancho * alto 
    
    override method valorInicialDeObra() =  material.valor() * self.volumen()
}

class Intervencion inherits Obra{
    const objeto //Ej de objeto: zapatilla,...,pintura,escultura

	override method valorInicialDeObra() =  10000 + objeto.valor()
}

class Deteriorada{//es una clase xq varian los puntosDeDeterioro segun la obra deteriorada
    const property puntosDeDeterioro = 10   //valor supuesto como minimo, cuando la instancian la clase lo pueden cambiar
		
    method valor(valorInicialDeObra){
    	const costoPorDeterioro = (puntosDeDeterioro/10).truncate(0)// $1 por cada 10 puntos de deterioro
    	return (valorInicialDeObra/2).min(valorInicialDeObra - costoPorDeterioro)
    }
    method costoDeRestauracion() = 1000 * self.puntosDeDeterioro()
    
    method restaurar(obra, presupuestoDisponible){
    	if(presupuestoDisponible >= self.costoDeRestauracion()) obra.estadoDeDeterioro(sana) else obra.estadoDeDeterioro(arruinada)  	
    }
}

object arruinada{ 
    method valor(valorInicialDeObra) = 0
	method restaurar(obra, presupuestoDisponible){
    	throw new RestaurarException(message = "Las obras Arruinadas NO PUEDEN ser restauradas")
    }
}

object sana{
    method valor(valorInicialDeObra) = valorInicialDeObra
    method restaurar(obra, presupuestoDisponible){}       
}


object galeria{
	const property obras = #{}
	 
	method obrasDelPeriodo(anioInicio,anioFin) = obras.filter{ obra => obra.anioDeCreacion().between(anioInicio,anioFin)}
	
	method autoresDelPeriodo(anioInicio,anioFin) = self.obrasDelPeriodo(anioInicio,anioFin).map({obra => obra.autor()}).asSet()//autores sin repetidos	
  
  	method obrasDelAutor(autor) = obras.filter{ obra => obra.autor() == autor}
  	
   	method valorTotalADeLasObras(autor) = self.obrasDelAutor(autor).sum{ obra => obra.valor()}
  
   	method obrasEnExposicion() = obras.filter{ obra => obra.estadoDeDeterioro()==sana 
   		|| ( obra.estadoDeDeterio().puntosDeDeterioro()<30 && obra.valor()<100000)}
   	
   	method obraMasCaraEnExposicion() = self.obrasEnExposicion().max{ obra => obra.valor()}  
}


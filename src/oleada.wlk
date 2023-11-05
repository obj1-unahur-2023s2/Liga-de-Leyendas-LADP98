class Oleada {
	var property cantDeMinions = 0
	var plusDeDanio 
	
	method plusDeDanio() = plusDeDanio
	
	method danio() = cantDeMinions + plusDeDanio
	
	method efectoDeBatalla(unCampeon){
		cantDeMinions -= unCampeon.puntosDeAtaque() / 2
		self.disminuirDanioExtra(unCampeon) 
	}
	
	method disminuirDanioExtra(unCampeon){
		if(unCampeon.puntosDeAtaque().between(20,40)){
			plusDeDanio -= 1
		}
		else if(unCampeon.puntosDeAtaque() > 40){
			plusDeDanio -= 2
		}
	}
}

class EjercitoDeMinions inherits Oleada{
	const property oleadas = []
	
	method cantidadDeMinionsDeOleadas(){
		return oleadas.sum({o=> o.cantDeMinions()})
	}
	
	override method danio(){
		return self.cantidadDeMinionsDeOleadas() + self.oleadaConPlusMaximo()
	}
	
	method oleadaConPlusMaximo() = oleadas.max({o=> o.plusDeDanio()}).plusDeDanio()
		
	override method efectoDeBatalla(unCampeon){
		if(oleadas.size() == 1){
			cantDeMinions -= unCampeon.puntosDeAtaque() / 2
			self.disminuirDanioExtra(unCampeon)
		}
		else if(oleadas.size() > 1){
			oleadas.forEach({o=> o.cantDeMinions(-(unCampeon.puntosDeAtaque() / 2) / 2) })
			self.disminuirDanioExtra(unCampeon)
		}
	}
}
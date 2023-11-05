class Item {
	const property peso
	
	method vidaQueOtorga(unCampeon){
		if(peso <= 500){
			return 20
		}
		else{
			return 40
		}
	} 
	
	method ataqueQueOtorga(unCampeon){
		if(peso <= 500){
			return 10
		}
		else{
			return 5
		}
	}
	
	method diferenciaDePuntosEntreAtaqueYVida(unCampeon){
		return (self.ataqueQueOtorga(unCampeon) - self.vidaQueOtorga(unCampeon))
	}
	
	method efectoDeEquipado(unCampeon)
	
	method efectoDeDesequipado(unCampeon)	
}

class AnilloDeDorean inherits Item{
	
	override method vidaQueOtorga(unCampeon) = super(unCampeon) + 60
	
	override method ataqueQueOtorga(unCampeon) = super(unCampeon) + 15
	
	override method efectoDeEquipado(unCampeon){
		unCampeon.puntosDeDanio(5)  
	} 
	
	override method efectoDeDesequipado(unCampeon){
		unCampeon.puntosDeDanio(- 10)
	}
}

class TomoAmplificador inherits Item{
	
	override method vidaQueOtorga(unCampeon) = super(unCampeon) + unCampeon.puntosDeDanio() * 0.25
	
	override method ataqueQueOtorga(unCampeon) = super(unCampeon) + unCampeon.puntosDeDanio() * 0.1
	
	override method efectoDeEquipado(unCampeon) {
		unCampeon.unidadesDeBloqueo(2)
	}
	
	override method efectoDeDesequipado(unCampeon){
		unCampeon.puntosDeDanio(30)
	}
}

class SombreroDeRabadon inherits TomoAmplificador{
	
	override method vidaQueOtorga(unCampeon) = super(unCampeon) * 2
	
	override method ataqueQueOtorga(unCampeon) = super(unCampeon) + 2
	
	override method efectoDeEquipado(unCampeon){
		super(unCampeon)
		unCampeon.puntosDeDanio(10)
	}
	
	override method efectoDeDesequipado(unCampeon){} 
}

class BastonDelVacio inherits Item{
	const property items = []
	
	override method vidaQueOtorga(unCampeon){
		return super(unCampeon) + self.vidaQueOtorganLosItemsInternos(unCampeon)
	}
	
	override method ataqueQueOtorga(unCampeon){
		return super(unCampeon) + self.ataqueQueOtorganLosItemsInternos(unCampeon)
	}
	
	method vidaQueOtorganLosItemsInternos(unCampeon){
		return items.sum({i=> i.vidaQueOtorga(unCampeon)})
	}
	
	method ataqueQueOtorganLosItemsInternos(unCampeon){
		return items.sum({i=> i.ataqueQueOtorga(unCampeon)})
	}
	
	override method efectoDeEquipado(unCampeon){}
	
	override method efectoDeDesequipado(unCampeon){}
}
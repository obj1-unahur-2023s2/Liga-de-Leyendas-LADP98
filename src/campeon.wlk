import oleada.*
import items.*

class Campeon {
	var puntosDeVida
	var property puntosDeAtaque
	var puntosDeDanio = 0
	const property items = #{}
	var unidadesDeBloqueo = 0
	
	method puntosDeVida() = puntosDeVida + self.vidaQueOtorganLosItems()
	
	method vidaQueOtorganLosItems() = items.sum({i=> i.vidaQueOtorga(self)})
	
	method ataqueQueOtorganLosItems() = items.sum({i=> i.ataqueQueOtorga(self)})
	
	method cantidadTotalDeAtaque() = puntosDeAtaque + self.ataqueQueOtorganLosItems()
	
	method puntosDeDanio() = puntosDeDanio
	
	method unidadesDeBloqueo() = unidadesDeBloqueo
	
	method unidadesDeBloqueo(unValor){
		unidadesDeBloqueo += unValor
	}
	
	method puntosDeDanio(unValor){
		puntosDeDanio = 0.max(puntosDeDanio + unValor)
	}
	
	method efectosDeBatalla(unaOleada){    // ETAPAAAAAAAAA 2!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		if(unidadesDeBloqueo != 0){
			unidadesDeBloqueo -= 1
		}
		else{
			puntosDeDanio += unaOleada.danio()	
		}	
	}  
	
	method equipar(unItem){
		items.add(unItem)
		unItem.efectoDeEquipado(self)
	}
	
	method desequipar(unItem){
		items.remove(unItem)
		unItem.efectoDeDesequipado(self)
	}
	
	method itemQueOtorgaMasPuntosDeVida(){
		return items.max({i=> i.vidaQueOtorga(self)})
	}
	
	method itemQueOtorgaMasAtaqueQueVida(){
		return items.max({i=> i.diferenciaDePuntosEntreAtaqueYVida(self)})
	}
	
	method hayItemQueOtorgueMayorVidaQue70(){
		return items.any({i=> i.vidaQueOtorga(self) > 70})
	}
	
	method hayItemQueOtorgueMayorAtaqueQue30(){
		return items.any({i=> i.ataqueQueOtorga(self) > 30})
	}
	
	method hayItemQueOtorgueMasDe70DeVidaOMasDe30DeAtaque(){
		return self.hayItemQueOtorgueMayorVidaQue70() or self.hayItemQueOtorgueMayorAtaqueQue30()
	}
	
	method pesoDeCadaItem(){
		return items.map({i=> i.peso()})
	}
	
	method itemsQuePesenMenosDe300(){
		return items.count({i=> i.peso() < 300})
	}
	
	method estaMuerto() = puntosDeVida <= puntosDeDanio
}
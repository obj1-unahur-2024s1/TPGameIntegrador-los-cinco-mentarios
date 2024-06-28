import wollok.game.*
import juego.*

object startGame{
	var property position = game.at(2,2)
	
	method image() = "assets/startGame.png"
}

object gameOver{
	var property position = game.at(2,2)
	
	method image() = "assets/gameOver.png"
}

class Num{
	var numero
	var property position
	
	method numero() = numero
	method image() = "assets/UI/numeral" + numero +".png"
	method chocar(){}
	method avanzar(){
		game.removeVisual(self)
		const siguienteNumero = new Num(numero = numero - 1, position = position)
		game.addVisual(siguienteNumero)
		if( numero == 0 ) {juego.finDelJuego()}
		return siguienteNumero
	}
}

class XMenu{
	var property position
	
	method image() = "assets/UI/numeralX.png"
	method chocar(){}
}

object naveHud{
	var property position = game.at(0,14)
	
	method image() = "assets/UI/playerLife1_blue.png"
	method chocar() {}
}

object meteoroHud{
	var property position = game.at(17,14)
	
	method image() = "assets/Meteors/meteorBrown_small2.png"
	method chocar() {}
}

class ObjetoInvisible{
	var property position
	method image(){
		return "assets/vacio.png"
	}
	method limiteDelJuego(){
		if(juego.todosMeteorosChocados()){
			juego.clearGameOver()
		}
	}
	
	/*
	 * La idea de este objeto es para solucionar el tema de que nos quedemos sin meteoros, mi idea era instanciar toda la primer fila
	 * con objetos "invisibles" y cuando los meteoros choquen con esta, que corra el metodo de arriba y revise si todos los meteoros
	 * principales fueron destruidos. Y si es asi que termine el juego. El metodo es medio rebuscado pero serviria.
	 * Diganme si se les ocurre una idea mas sencilla.
	 */
	method meChocoLaNave(){}
}
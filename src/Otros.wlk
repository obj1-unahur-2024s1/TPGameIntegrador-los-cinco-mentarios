import wollok.game.*
import juego.*

object startGame{
	var property position = game.at(4,5)
	
	method image() = "assets/start-game.png"
}

object gameOver{
	var property position = game.at(4,4)
	
	method image() = "assets/game-over.png"
}

class Num{
	var numero
	var property position = game.at(2,14)
	
	method image() = "assets/UI/numeral" + numero +".png"
	method chocar(){}
	method avanzar(){
		game.removeVisual(self)
		const siguienteNumero = new Num(numero = numero - 1)
		game.addVisual(siguienteNumero)
		if( numero == 0 ) {juego.finDelJuego()}
		return siguienteNumero
	}
}

object xMenu{
	var property position = game.at(1, 14)
	
	method image() = "assets/UI/numeralX.png"
	method chocar(){}
}

object naveHud{
	var property position = game.at(0,14)
	
	method image() = "assets/UI/playerLife1_blue.png"
	method chocar() {}
}
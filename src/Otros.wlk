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
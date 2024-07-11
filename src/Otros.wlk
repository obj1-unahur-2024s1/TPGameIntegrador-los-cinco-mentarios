import wollok.game.*
import juego.*

object startGame{
	var property position = game.at(2,2)
	
	method image() = "assets/startGameFinalFill.png"
}

object gameOverGanaste{
	var property position = game.at(2,2)
	
	method image() = "assets/game-over-ganaste.png"
}

object gameOverMeteoros{
	var property position = game.at(2,2)
	
	method image() = "assets/game-over-sinmeteoros.png"
}

object gameOverVidas{
	var property position = game.at(2,2)
	
	method image() = "assets/game-over-sinvidas.png"
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
	method esMeteoro() = false
}

class XMenu{
	var property position
	
	method image() = "assets/UI/numeralX.png"
	method chocar(){}
	method esMeteoro() = false
}

object naveHud{
	var property position = game.at(0,14)
	
	method image() = "assets/UI/playerLife1_blue.png"
	method chocar() {}
	method esMeteoro() = false
}

object meteoroHud{
	var property position = game.at(17,14)
	
	method image() = "assets/Meteors/meteorBrown_small2.png"
	method chocar() {}
	method esMeteoro() = false
}


class SonidoIntro{
	const sonido = game.sound("assets/Effects/game-music-loop-3-144252.mp3")
	method play(){
		sonido.play()
	}
	
	method stop(){
		sonido.stop()
	}
}

class SonidoJuego{
	const sonido = game.sound("assets/Effects/epic-game-music-by-kris-klavenes-3-mins-49771.mp3")
	method play(){
		sonido.play()
	}
	
	method stop(){
		sonido.stop()
	}
}

class SonidoOutro{
	const sonido = game.sound("assets/Effects/mixkit-retro-arcade-game-over-470.wav")
	method play(){
		sonido.play()
	}
	
	method stop(){
		sonido.stop()
	}
}

class SonidoWin{
	const sonido = game.sound("assets/Effects/success-1-6297.mp3")
	method play(){
		sonido.play()
	}
	
	method stop(){
		sonido.stop()
	}
}
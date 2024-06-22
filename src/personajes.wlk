import wollok.game.*
import Laser.*
import Meteoro.*
import Nave.*

object naveInicial inherits Nave {
	
	override method image(){
		return "assets/Naves/playerShip1_blue.png"
	}
	
	override method disparar(){
		const laser = new Laser(unaNave=self)
		game.addVisual(laser)
		game.onTick(100, "laser", {laser.arriba()})
		game.onCollideDo(laser, {algo => algo.chocar()})
		//game.schedule(100, {laser.remover()})
	}
}

object startGame{
	var property position = game.at(4,5)
	
	method image() = "assets/start-game.png"
}

object gameOver{
	var property position = game.at(4,4)
	
	method image() = "assets/game-over.png"
}

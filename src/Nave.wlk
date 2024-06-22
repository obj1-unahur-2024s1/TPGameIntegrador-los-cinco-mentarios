import wollok.game.*
import Laser.*

class Nave {
	var property vida = 3
	var property position = game.at(13, 0)
	
	method image(){
		return "assets/Naves/playerShip1_blue.png"
	}
	
	method arriba(){
		position = position.up(1)
	}
	
	method abajo(){
		position = position.down(1)
	}
	
	method izquierda(){
		position = position.left(1)
	}
	
	method derecha(){
		position = position.right(1)
	}
	
	method disminuirUnaVida(){
		vida = vida - 1
	}
	
	method disparar(){
		const laser = new Laser(unaNave=self)
		game.addVisual(laser)
		game.onTick(100, "laser", {laser.arriba()})
		game.onCollideDo(laser, {algo => algo.chocar()})
		
	}

}

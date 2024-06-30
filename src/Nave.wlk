import wollok.game.*
import Laser.*

class Nave {
	var property vida = 3
	var property position = game.at(9, 0)	
	
	method image(){
		return "assets/Naves/playerShip1_blueR.png"
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
		const sonidoPerdidaVida = game.sound("assets/Naves/videogame-death-sound-43894.mp3")
		vida = vida - 1
		sonidoPerdidaVida.play()
	}
	
	method disparar(){
		const laser = new Laser(unaNave=self)
		const audioLaser = game.sound("assets/Lasers/lasergun-35817 (mp3cut.net).mp3")
		
		game.addVisual(laser)
		game.onTick(100, "laser",{laser.arriba()})
		game.schedule(100,{audioLaser.play()})	
		game.onCollideDo(laser, {algo => algo.chocar()})
		
	}
	
	method esMeteoro() = false

}

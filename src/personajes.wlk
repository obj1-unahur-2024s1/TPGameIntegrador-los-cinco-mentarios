import wollok.game.*

object nave {
	var property position = game.at(13, 0)
	
	method image() = "assets/Naves/playerShip1_blue.png"
	
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
	
	method disparar(){
		const laserClase = new Laser()
		game.addVisual(laserClase)
		game.onTick(100, "laser", {laserClase.arriba()})
		game.onCollideDo(laserClase, {algo => algo.chocar()})
		game.schedule(1500, {laserClase.remover()})
	}
}

class Meteoro {
	var property position
	
	method image() = "assets/Meteors/meteorBrown_big1.png"
	method chocar(){
		game.say(self,"Me diste!")
		game.schedule(500, {game.removeVisual(self)})
	}
}

class Laser {
	var property position = nave.position().up(2)
	
	method image() = "assets/Lasers/laserGreen10.png"
	method arriba(){
		position = position.up(1)
		
	}
	
	method remover(){
		game.removeVisual(self)
	}
	
}
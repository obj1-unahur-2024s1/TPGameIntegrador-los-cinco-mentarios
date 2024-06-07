import wollok.game.*

object nave {
	var property position = game.origin()
	
	method image() = "playerShip1_blue.png"
	
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
		game.onCollideDo(meteoro, {a => meteoro.chocar()})
		game.schedule(1200, {laserClase.remover()})
	}
}

object meteoro {
	var property position = game.at(8,10)
	
	method image() = "meteorBrown_big1.png"
	method chocar(){
		game.say(self,"Me diste!")

	}
}

class Laser {
	var property position = nave.position().up(2)
	
	method image() = "laserGreen10.png"
	method arriba(){
		position = position.up(1)
	}
	
	method remover(){
		game.removeVisual(self)
	}
	
}

object choque {
	var property position = meteoro.position()
	
	method image() = "laserGreen14.png"
	
	method remover(){
		game.removeVisual(self)
	}
	
}
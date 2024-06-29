import wollok.game.*

class Laser {
	var unaNave
	var property position = unaNave.position().up(2)
	
	method image() = "assets/Lasers/laserBlue10.png"
	
	method arriba(){
		position = position.up(1)
	}
	
	method remover(){
		game.removeVisual(self)
	}
	
	method chocar(){
		game.say(self,"¡Impacto!")
		game.schedule(100, {game.removeVisual(self)})
	}
	
	method esMeteoro() = false
}
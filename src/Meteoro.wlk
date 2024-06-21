import wollok.game.*
import juego.*

class Meteoro {
	var property position
	var property meChocaron = false
	
	method image(){
		return ""
	}
	
	method chocar(){
		game.say(self,"!Me diste!")
		meChocaron = true
		game.schedule(500, {game.removeVisual(self)})
		juego.finDelJuego()
	}
}

class MeteoroPequenio inherits Meteoro {
	
	override method image(){
		return "assets/Meteors/MeteorBrown_tiny1.png"
	}
	
}

class MeteoroChico inherits Meteoro {
	
	override method image(){
		return "assets/Meteors/MeteorBrown_small1.png"
	}
	
}

class MeteoroMediano inherits Meteoro {
	
	override method image(){
		return "assets/Meteors/MeteorBrown_med1.png"
	}
	
}

class MeteoroGrande inherits Meteoro {
	
	override method image(){
		return "assets/Meteors/MeteorBrown_big1.png"
	}
	
}
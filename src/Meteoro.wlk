import wollok.game.*

class Meteoro {
	var property position
	
	method image(){
		return ""
	}
	
	method chocar(){
		game.say(self,"!Me diste!")
		game.schedule(500, {game.removeVisual(self)})
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
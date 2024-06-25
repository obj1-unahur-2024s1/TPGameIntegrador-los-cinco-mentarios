import wollok.game.*
import juego.*

class Meteoro {
	var property position
	var property meDestruyeron = false
	const sonidoRoturaMeteoro = game.sound("assets/Meteors/small-rock-break-194553 (mp3cut.net).mp3")
	
	method image(){
		return ""
	}
	
	method chocar(){
		game.say(self,"¡Me diste!")
		sonidoRoturaMeteoro.play()
		meDestruyeron = true
		game.schedule(500, {game.removeVisual(self)})
		juego.quitarUnMeteoro()
		juego.finDelJuego()
	}
	
	method abajo(){
		position = position.down(1)
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
	
	override method chocar(){
        const meteoroPequenio = new MeteoroPequenio(position = self.position())
        game.addVisual(meteoroPequenio)
        game.onTick(500, "meteoroPequenio", {meteoroPequenio.abajo()})
        super()
    }	
}

class MeteoroGrande inherits Meteoro {
	
	override method image(){
		return "assets/Meteors/MeteorBrown_big1.png"
	}
	
	override method chocar(){
		const meteoroMediano = new MeteoroMediano(position = self.position())
        game.addVisual(meteoroMediano)
        game.onTick(1000, "meteoroMediano", {meteoroMediano.abajo()})
        super()
	}
	
}
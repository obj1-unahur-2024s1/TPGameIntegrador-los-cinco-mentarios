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
	
	method esMeteoro() = true
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
        game.schedule(7000, {if(game.hasVisual(meteoroPequenio)){game.removeVisual(meteoroPequenio)}})
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
        game.onTick(500, "meteoroMediano", {meteoroMediano.abajo()})
        game.schedule(7000, {if(game.hasVisual(meteoroMediano)){game.removeVisual(meteoroMediano)}})
        super()
	}
	
}

class MeteoroInvisible inherits Meteoro{
	override method image(){
		return "assets/vacio.png"
	}
	
	override method chocar() {
		const meteoroMediano = new MeteoroMediano(position = self.position())
		const meteoroGrande1 = juego.nivelActual().meteoroGrande1()
		const meteoroGrande2 = juego.nivelActual().meteoroGrande2()
		
        game.addVisual(meteoroMediano)
        game.onTick(500, "meteoroPequenio", {meteoroMediano.abajo()})
        game.schedule(7000, {if(game.hasVisual(meteoroMediano)){game.removeVisual(meteoroMediano)}})
        game.say(self,"¡Me diste!")
		sonidoRoturaMeteoro.play()
		meDestruyeron = true
		if (meteoroGrande1.contains(self)){
			game.schedule(500, {meteoroGrande1.forEach{m=>game.removeVisual(m)}})
			juego.quitarUnMeteoro()
			juego.finDelJuego()
        }
        else{
        	game.schedule(500, {meteoroGrande2.forEach{m=>game.removeVisual(m)}})
			juego.quitarUnMeteoro()
			juego.finDelJuego()
        }
        
}		
	
	
	override method esMeteoro() = false
}
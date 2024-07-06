import wollok.game.*
import Meteoro.*
import Otros.*

class Nivel1 {
	const meteoro1 = new MeteoroChico(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro2 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro3 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro4 = new MeteoroPequenio(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	
	var property meteoros = [meteoro1, meteoro2, meteoro3, meteoro4]
	var property meteorosInvisibles = []
	var property numCantMeteoros = new Num (numero = 5, position = game.at(19,14))
	
	const property meteoroGrande1 = []
	
	const property meteoroGrande2 = []
	
	method iniciar() {
	    game.addVisual(imagenNivel1)
	    game.schedule(2000, {game.removeVisual(imagenNivel1)})
	}
}

object imagenNivel1{
	var property position = game.at(7, 3)
	
	method image() = "assets/nivel1.png"
	
	method esMeteoro() = false
	
	method chocar() {}
}

class Nivel2 {
	const meteoro1 = new MeteoroChico(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro2 = new MeteoroChico(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro3 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	
	//Meteoro 4 Grande y sus 3 meteoros invisibles alrededor del mismo.
	const meteoro4 = new MeteoroGrande(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro4Invisible1 = new MeteoroInvisible(position = meteoro4.position().right(1))
	
	
	
	//Meteoro 5 Grande y sus 3 meteoros invisibles alrededor del mismo.
	const meteoro5 = new MeteoroGrande(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro5Invisible1 = new MeteoroInvisible(position = meteoro5.position().right(1))
	
	
	
	var property meteoros = [meteoro1,meteoro2,meteoro3,meteoro4, meteoro5]
	var property meteorosInvisibles = [meteoro4Invisible1,meteoro5Invisible1]
	var property numCantMeteoros = new Num (numero = 9, position = game.at(19,14))
	
	const property meteoroGrande1 = [meteoro4,meteoro4Invisible1]
	
	const property meteoroGrande2 = [meteoro5,meteoro5Invisible1]
	
	
	method iniciar() {
	    game.addVisual(imagenNivel2)
	    game.schedule(2000, {game.removeVisual(imagenNivel2)})
	}
	
}

object imagenNivel2{
	var property position = game.at(7, 3)
	
	method image() = "assets/nivel2.png"
	
	method esMeteoro() = false
	
	method chocar() {}
}
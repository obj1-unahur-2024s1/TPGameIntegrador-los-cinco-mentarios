import wollok.game.*
import personajes.*
import Laser.*	
import Meteoro.*

object juego{
	
	method loadVisuals(){
		const meteoro1 = new MeteoroPequenio(position = game.at(0.randomUpTo(28).roundUp(),5.randomUpTo(13).roundUp()))
		const meteoro2 = new MeteoroChico(position = game.at(0.randomUpTo(28).roundUp(),5.randomUpTo(13).roundUp()))
		const meteoro3 = new MeteoroMediano(position = game.at(0.randomUpTo(28).roundUp(),5.randomUpTo(13).roundUp()))
		const meteoro4 = new MeteoroGrande(position = game.at(0.randomUpTo(28).roundUp(),5.randomUpTo(13).roundUp()))
		
		game.width(30)
		game.height(15)
		game.boardGround("assets/background.png")
		game.addVisualCharacter(naveInicial)
		game.addVisual(meteoro1)
		game.addVisual(meteoro2)
		game.addVisual(meteoro3)
		game.addVisual(meteoro4)
	}
	
	method loadKeys(){
		keyboard.space().onPressDo {naveInicial.disparar()}
	}
	
	method iniciar(){
		self.loadVisuals()
		self.loadKeys()
		game.start()
	}
}
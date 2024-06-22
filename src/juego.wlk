import wollok.game.*
import personajes.*
import Laser.*	
import Meteoro.*

object juego{
	
	const meteoro1 = new MeteoroPequenio(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro2 = new MeteoroChico(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro3 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro4 = new MeteoroGrande(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro5 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	
	const meteoros = [meteoro1,meteoro2,meteoro3,meteoro4,meteoro5]
	
	method loadVisuals(){		
		//game.width(20)
		//game.height(15)
		//game.boardGround("assets/background.png")
		game.addVisualCharacter(naveInicial)
		game.addVisual(meteoro1)
		game.addVisual(meteoro2)
		game.addVisual(meteoro3)
		game.addVisual(meteoro4)
		game.addVisual(meteoro5)
	}
	
	method loadKeys(){
		keyboard.space().onPressDo {naveInicial.disparar()}
	}
	
	method iniciar(){
		game.width(20)
		game.height(15)
		game.boardGround("assets/background.png")
		game.addVisual(startGame)
		keyboard.enter().onPressDo {self.cargarTodo()}
		game.start()
	}
	
	method cargarTodo(){
		game.removeVisual(startGame)
		self.loadVisuals()
		self.loadKeys()
		//game.start()
	}
	
	method todosMeteorosChocados() = meteoros.all({unMeteoro => unMeteoro.meChocaron()})
	
	method finDelJuego(){
		if(self.todosMeteorosChocados() or naveInicial.vida() == 0)
		{
			game.clear()
			game.addVisual(gameOver)
		}
		
	}
}
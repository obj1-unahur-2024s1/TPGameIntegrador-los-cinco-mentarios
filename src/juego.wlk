import wollok.game.*
import Otros.*	
import Meteoro.*
import Nave.*

object juego{
	
	const meteoro1 = new MeteoroPequenio(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro2 = new MeteoroChico(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro3 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro4 = new MeteoroGrande(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro5 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	
	var numVidasNave = new Num(numero=3)
	
	const naveInicial = new Nave()
	
	const meteoros = [meteoro1,meteoro2,meteoro3,meteoro4,meteoro5]
	
	method loadVisuals(){		
		game.addVisualCharacter(naveInicial)
		game.addVisual(meteoro1)
		game.addVisual(meteoro2)
		game.addVisual(meteoro3)
		game.addVisual(meteoro4)
		game.addVisual(meteoro5)
		game.addVisual(numVidasNave)
		game.addVisual(xMenu)
		game.addVisual(naveHud)
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
		game.onCollideDo(naveInicial, {algo => self.eliminarUnaVida()}) 
	}
	
	method agregarMeteoro(unMeteoro) {meteoros.add(unMeteoro)}
	
	method todosMeteorosChocados() = meteoros.all({unMeteoro => unMeteoro.meChocaron()})
	
	method finDelJuego(){
		if(self.todosMeteorosChocados() or naveInicial.vida() == 0)
		{
			game.clear()
			game.addVisual(gameOver)
		}
		
	}
	
	method eliminarUnaVida(){
		naveInicial.disminuirUnaVida()
		self.avanzarNumero()
		self.finDelJuego()
	}
	
	method avanzarNumero(){
		numVidasNave = numVidasNave.avanzar()
	}
}
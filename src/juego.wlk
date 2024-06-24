import wollok.game.*
import Otros.*	
import Meteoro.*
import Nave.*

object juego{
	
	var meteorosAAgregar = new MeteorosAgregar5()//Ver esto
	
	var numVidasNave = new Num(numero=3, position = game.at(2,14))
	var numCantMeteoros = new Num (numero = 5, position = game.at(19,14))
	
	const naveInicial = new Nave()
	
	const xMenu1 = new XMenu(position = game.at(1, 14))
	const xMenu2 = new XMenu(position = game.at(18, 14))
	
	var todoCargado = false
	var estoyEnSegundoNivel = false
	
	const sonidoIntro = game.sound("assets/Effects/game-music-loop-3-144252.mp3")
	const sonidoJuego = game.sound("assets/Effects/epic-game-music-by-kris-klavenes-3-mins-49771.mp3")
	const sonidoOutro = game.sound("assets/Effects/game-music-loop-3-144252.mp3")	
	
	method loadVisuals(){		
		game.addVisualCharacter(naveInicial)
		self.agregar5MeteoroAlTablero()
		game.addVisual(numVidasNave)
		game.addVisual(numCantMeteoros)
		game.addVisual(xMenu1)
		game.addVisual(xMenu2)
		game.addVisual(naveHud)
		game.addVisual(meteoroHud)
	}
	
	method loadKeys(){
		keyboard.space().onPressDo {naveInicial.disparar()}
	}
	
	method iniciar(){
		
		game.width(20)
		game.height(15)
		game.boardGround("assets/background.png")
		game.addVisual(startGame)
		game.schedule(100,{sonidoIntro.play()})
		keyboard.enter().onPressDo {self.cargarTodo()}
		game.start()
		
	}
	
	method cargarTodo(){
		if( not todoCargado )
		{
			sonidoIntro.stop()
			game.removeVisual(startGame)
			sonidoJuego.play()
			self.loadVisuals()
			self.loadKeys()
			game.onCollideDo(naveInicial, {algo => self.eliminarUnaVida()})
			todoCargado = true 
		}
		
		
	}
	
	method agregar5MeteoroAlTablero(){
		meteorosAAgregar = new MeteorosAgregar5()
		meteorosAAgregar.meteoros().forEach({unMeteoro => game.addVisual(unMeteoro)})
	}
	
	method todosMeteorosChocados() = meteorosAAgregar.meteoros().all({unMeteoro => unMeteoro.meDestruyeron()})
	
	method finDelJuego(){
		if(numCantMeteoros.numero() == 0 and (not estoyEnSegundoNivel))//Si entra a este IF esta en el primer nivel y destruyo los 5 meteoros
		{
			game.removeVisual(numCantMeteoros)
			numCantMeteoros = new Num (numero = 9, position = game.at(19,14))
			game.addVisual(numCantMeteoros)
			self.agregar5MeteoroAlTablero()
			self.agregar5MeteoroAlTablero()
			estoyEnSegundoNivel = true		
		}
		if(naveInicial.vida() == 0 or (numCantMeteoros.numero() == 0 and estoyEnSegundoNivel))//Si entra a este IF destruyo los 9 meteoros del nivel 2
		{
			game.clear()
			sonidoJuego.stop()
			game.schedule(100,{sonidoOutro.play()})
			game.addVisual(gameOver)
		}		
	}
	
	method eliminarUnaVida(){
		naveInicial.disminuirUnaVida()
		self.avanzarNumeroVidas()
		self.finDelJuego()
	}
	
	method avanzarNumeroVidas(){
		numVidasNave = numVidasNave.avanzar()
	}

	method quitarUnMeteoro(){
		numCantMeteoros = numCantMeteoros.avanzar()
	}
}
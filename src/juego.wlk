import wollok.game.*
import Otros.*	
import Meteoro.*
import Nave.*

object juego{
	
	const meteoro1 = new MeteoroChico(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro2 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro3 = new MeteoroMediano(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro4 = new MeteoroGrande(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro5 = new MeteoroGrande(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	const meteoro6 = new MeteoroGrande(position = game.at(0.randomUpTo(18),5.randomUpTo(13)))
	
	const meteoros = [meteoro1,meteoro2,meteoro3,meteoro4,meteoro5,meteoro6]
	var numCantMeteoros = new Num (numero = 5, position = game.at(19,14))
	
	const naveInicial = new Nave()
	var numVidasNave = new Num(numero=3, position = game.at(2,14))
	
	const xMenu1 = new XMenu(position = game.at(1, 14))
	const xMenu2 = new XMenu(position = game.at(18, 14))
	
	var todoCargado = false
	
	const sonidoIntro = game.sound("assets/Effects/game-music-loop-3-144252.mp3")
	const sonidoJuego = game.sound("assets/Effects/epic-game-music-by-kris-klavenes-3-mins-49771.mp3")
	const sonidoOutro = game.sound("assets/Effects/game-music-loop-3-144252.mp3")	
	
	method loadVisuals(){		
		game.addVisualCharacter(naveInicial)
		meteoros.forEach({unMeteoro => game.addVisual(unMeteoro)})
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
		if( not todoCargado ){
			sonidoIntro.stop()
			game.removeVisual(startGame)
			sonidoJuego.play()
			self.loadVisuals()
			self.loadKeys()
			game.onCollideDo(naveInicial, {algo => self.eliminarUnaVida()})
			todoCargado = true 
		}
	}
	
	method agregarMeteoro(unMeteoro) {
		meteoros.add(unMeteoro)
	}
	
	method todosMeteorosChocados() = meteoros.all({unMeteoro => unMeteoro.meDestruyeron()})
	
	method finDelJuego(){
		if(self.todosMeteorosChocados() or naveInicial.vida() == 0 or numCantMeteoros.numero() == 0){
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
	
	method cantidadMeteorosSinDestruir() = meteoros.count({unMeteoro =>not unMeteoro.meDestruyeron()})
	
	method quitarUnMeteoro(){
		numCantMeteoros = numCantMeteoros.avanzar()
	}
}
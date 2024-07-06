import wollok.game.*
import Otros.*	
import Nave.*
import Niveles.*

object juego{
	
	var nivelActual = new Nivel1()
	var esNivel2 = false
	
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
		nivelActual.meteoros().forEach({unMeteoro => game.addVisual(unMeteoro)})
		nivelActual.meteorosInvisibles().forEach({unMeteoro => game.addVisual(unMeteoro)})
		game.addVisual(numVidasNave)
		game.addVisual(nivelActual.numCantMeteoros())
		game.addVisual(xMenu1)
		game.addVisual(xMenu2)
		game.addVisual(naveHud)
		game.addVisual(meteoroHud)
	}
	
	method loadKeys(){
		keyboard.space().onPressDo{naveInicial.disparar()}
		keyboard.r().onPressDo{self.reiniciarNivel()}
		
	}
	
	method loadComportamiento(){
		game.onCollideDo(naveInicial, { algo => self.eliminarUnaVida() })
		game.onTick(1000, "VerificarMeteorosConVida", {self.verificarMeteoros()})
	}
	
	method quedanMeteorosConVida(){
		return game.allVisuals().filter({algo => algo.esMeteoro()}).isEmpty()
	}
	
	method verificarMeteoros(){
		if(self.quedanMeteorosConVida() and self.todosMeteorosChocados())
		{
			self.clearGameOver()
		}
	}
	
	method iniciar(){
		game.width(20)
		game.height(15)
		game.boardGround("assets/background.png")
		game.addVisual(startGame)
		game.schedule(100,{sonidoIntro.play()})
		keyboard.enter().onPressDo{self.cargarTodo()}
		game.start()
	}
	
	method cargarNivel() {
        game.clear()
        nivelActual.iniciar()
        self.loadVisuals()
    }
    
    method reiniciarNivel(){
    	game.clear()
    	if(esNivel2){nivelActual = new Nivel2()} else {nivelActual = new Nivel1()}
    	numVidasNave = new Num(numero=3, position = game.at(2,14))
    	naveInicial.vida(3)
    	nivelActual.iniciar()
        self.loadVisuals()
        self.loadKeys()
        self.loadComportamiento()
    }

    method cargarTodo() {
        if (not todoCargado) {
            sonidoIntro.stop()
            game.removeVisual(startGame)
            sonidoJuego.play()
            self.cargarNivel()
            self.loadKeys()
            self.loadComportamiento()
            todoCargado = true
        }
    }
	
	method agregarMeteoro(unMeteoro) {
		nivelActual.meteoros().add(unMeteoro)
	}
	
	method todosMeteorosChocados() = nivelActual.meteoros().all({unMeteoro => unMeteoro.meDestruyeron()})
	
	method finDelJuego(){
		if(naveInicial.vida() == 0){
			self.clearGameOver()
			
		}
		if(nivelActual.numCantMeteoros().numero() == 0 and not esNivel2){
			nivelActual = new Nivel2()
			esNivel2 = true
			self.cargarNivel()
            self.loadKeys()
            self.loadComportamiento()
            todoCargado = true
		}
		if (esNivel2 and nivelActual.numCantMeteoros().numero() == 0) {
			self.clearGameOver()
		}
	}
	
	method clearGameOver(){
		game.clear()
		sonidoJuego.stop()
		game.schedule(100,{sonidoOutro.play()})
		if(esNivel2 and nivelActual.numCantMeteoros().numero() == 0){
			game.addVisual(gameOverGanaste)
			
		}
		else
		{
			if(self.quedanMeteorosConVida() and self.todosMeteorosChocados()){
				game.addVisual(gameOverMeteoros)
				
			}
			else
			{
				if(naveInicial.vida() == 0){game.addVisual(gameOverVidas)}
					
			}
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
	
	method cantidadMeteorosSinDestruir() = nivelActual.meteoros().count({unMeteoro =>not unMeteoro.meDestruyeron()})
	
	method quitarUnMeteoro(){
		nivelActual.numCantMeteoros((nivelActual.numCantMeteoros().avanzar()))
	}
	
	method nivelActual(){return nivelActual}
	
	
	
}
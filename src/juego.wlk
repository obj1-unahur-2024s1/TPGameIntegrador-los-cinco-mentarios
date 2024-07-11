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
	
	var sonidoActual
	
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
		sonidoActual = new SonidoIntro()
		game.schedule(100,{sonidoActual.play()})
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
            sonidoActual.stop()
            game.removeVisual(startGame)
            sonidoActual = new SonidoJuego()
            sonidoActual.play()
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
	
	method reiniciarJuego(){
		game.clear()
		sonidoActual.stop()
		sonidoActual = new SonidoJuego()
		sonidoActual.play()
		esNivel2 = false
		nivelActual.iniciar()
        self.loadVisuals()
		self.loadKeys()
		self.loadComportamiento()
	}
	
	method clearGameOver(){
		game.clear()
		sonidoActual.stop()
		keyboard.r().onPressDo{self.reiniciarJuego()}
		if(esNivel2 and nivelActual.numCantMeteoros().numero() == 0){
			game.addVisual(gameOverGanaste)
			sonidoActual = new SonidoWin()
			sonidoActual.play()
		}
		else
		{
			if(self.quedanMeteorosConVida() and self.todosMeteorosChocados()){
				game.addVisual(gameOverMeteoros)
				sonidoActual = new SonidoOutro()
				sonidoActual.play()
			}
			else
			{
				if(naveInicial.vida() == 0){
					game.addVisual(gameOverVidas)
					sonidoActual = new SonidoOutro()
					sonidoActual.play()
				}
					
			}
		}
		sonidoActual = new SonidoIntro()
		sonidoActual.play()
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
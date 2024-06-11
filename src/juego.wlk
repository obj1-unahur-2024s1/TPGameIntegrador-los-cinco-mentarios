import wollok.game.*
import personajes.*

object juego{
	method iniciar(){
		const meteoro1 = new Meteoro(position = game.at(0.randomUpTo(28).roundUp(),5.randomUpTo(13).roundUp()))
		const meteoro2 = new Meteoro(position = game.at(0.randomUpTo(28).roundUp(),5.randomUpTo(13).roundUp()))
		const meteoro3 = new Meteoro(position = game.at(0.randomUpTo(28).roundUp(),5.randomUpTo(13).roundUp()))
		game.width(30)
		game.height(15)
		game.boardGround("assets/background.png")
		game.addVisualCharacter(nave)
		game.addVisual(meteoro1)
		game.addVisual(meteoro2)
		game.addVisual(meteoro3)
		keyboard.enter().onPressDo {nave.disparar()}
		/*
		 * game.onCollideDo(meteoro1, {a => meteoro1.chocar()})
		 * game.onCollideDo(meteoro2, {a => meteoro2.chocar()})
		 * game.onCollideDo(meteoro3, {a => meteoro3.chocar()})
		 * 
		 */
		
		
		
	}
}
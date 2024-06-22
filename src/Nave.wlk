import wollok.game.*

class Nave {
	var property vida = 3
	var property position = game.at(13, 0)
	
	method image(){
		return ""
	}
	
	method arriba(){
		position = position.up(1)
	}
	
	method abajo(){
		position = position.down(1)
	}
	
	method izquierda(){
		position = position.left(1)
	}
	
	method derecha(){
		position = position.right(1)
	}
	
	method disparar(){}
	
	method chocar(){
		if(self.vida() != 0){
			vida = self.vida() - 1
			game.say(self,"¡Impacto recibido!")
		}
	}
}

import wollok.game.*

class Nave {
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
	
}

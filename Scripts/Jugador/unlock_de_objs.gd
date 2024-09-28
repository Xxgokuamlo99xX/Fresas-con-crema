extends Node

@export var obj_unlock : String

func desbloqueo():
	match obj_unlock:
		"bola_de_fuego":
			if not GlobalVar.get(obj_unlock):
				GlobalVar.bola_de_fuego = true

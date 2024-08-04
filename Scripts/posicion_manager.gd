extends Node

func _ready():
	if GlobalVar.nivel_anterior != null:
		get_node("Goku").set_position(get_node(GlobalVar.nivel_anterior + " Pos").position)
	GlobalVar.puede_moverse = true

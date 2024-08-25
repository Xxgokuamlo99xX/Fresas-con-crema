extends Node

#Syntaxis del marker :v == "nombre del lugar a donde va la puerta" Pos

func _ready():
	if GlobalVar.nivel_anterior != null:
		get_node("Goku").set_position(get_node("Markers_pos").get_node(GlobalVar.nivel_anterior + " Pos").position)

	GlobalVar.puede_moverse = true

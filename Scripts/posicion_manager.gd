extends Node

#Syntaxis del marker :v == "nombre del lugar a donde va la puerta" Pos

func _ready():
	if GlobalVar.nivel_anterior != null:
		if get_tree().current_scene.name != GlobalVar.nivel_anterior:
			get_node("Goku").set_position(get_node("Markers_pos").get_node(GlobalVar.nivel_anterior + " Pos").position)
			GlobalVar.puede_moverse = true
		else: 
			return
	else:
		return
	GlobalVar.puede_moverse = true

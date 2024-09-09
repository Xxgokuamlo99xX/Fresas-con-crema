extends Node2D

@export_category("Tipos de item")
## 1 -> corazon, 2 -> mana, 3 -> eter 
@export var Id_item : int 


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
		match Id_item:
			1:
				GlobalVar.vida_jugador += 20
				body.curarse.emit()
				
			2:
				GlobalVar.mana += 50
				
			3:
				GlobalVar.eter += 5
				
		get_parent().queue_free()

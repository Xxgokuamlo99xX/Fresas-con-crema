extends Area2D



func _on_area_entered(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
		GlobalVar.estado_jugador = "Agua"

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
			GlobalVar.estado_jugador = "Tierra"

extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
		GlobalVar.eter += 1
		queue_free()

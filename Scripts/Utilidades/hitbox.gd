extends Area2D

@export var damage : int 
@export var borrar_en_hit : bool

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
		GlobalVar.player_damage_taken = damage
		body._damage()
		await get_tree().create_timer(0.1).timeout
		if borrar_en_hit:
			get_parent().queue_free()

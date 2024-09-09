extends Area2D

@export var parallax : Node2D
@export var camara_target : PhantomCamera2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
		parallax.scale.y = 2
		camara_target.priority = 5
		

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
			parallax.scale.y = 1
			camara_target.priority = 0

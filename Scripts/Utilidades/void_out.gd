extends Area2D

@export var Posicion_rec : Marker2D
var jugador

func _void(jugador):
	jugador = get_parent().get_node("Goku")
	GlobalVar.puede_moverse = false
	$AnimationPlayer.play("irse")
	await $AnimationPlayer.animation_finished
	jugador.global_position = Posicion_rec.global_position
	jugador.state_machine.travel("Idle")
	$AnimationPlayer.play_backwards("irse")
	await $AnimationPlayer.animation_finished
	GlobalVar.puede_moverse = true
	
func _on_body_entered(body: Node2D) -> void:
	_void(jugador)

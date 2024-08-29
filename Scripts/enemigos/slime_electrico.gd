extends "res://Scripts/enemigos/slime_ia.gd"

@export var tiempo_ataque : Timer

func atacar():
	if tiempo_ataque.is_stopped() && invul.is_stopped():
		tiempo_ataque.start()
		puede_moverse = false
		hitbox.monitorable = false
		$AnimationPlayer.play("Ataque")
		await $AnimationPlayer.animation_finished
		puede_moverse = true
		hitbox.monitorable = true
 
	
func _process(delta: float) -> void:
	atacar()

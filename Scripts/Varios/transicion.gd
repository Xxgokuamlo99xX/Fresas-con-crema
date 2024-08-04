extends CanvasLayer

func cambio_escena(escena : StringName) -> void:
	$AnimationPlayer.play("irse")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(escena)
	$AnimationPlayer.play_backwards("irse")
	

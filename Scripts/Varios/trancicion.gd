extends CanvasLayer

func cambiar_escena(target: String) -> void:
	$AnimationPlayer.play("Desvanecerse")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("Desvanecerse")
	
	

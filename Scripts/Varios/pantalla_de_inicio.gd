extends Node

@warning_ignore("unused_parameter")

func _process(delta: float) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_button_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	cambiar_escena.show()
	cambiar_escena.cambio_escena("res://Escenas/2D/niveles/lvl_1(prueba).tscn")
	
func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_cargar_pressed() -> void:
	GlobalVar.cargar_partida()

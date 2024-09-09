extends CanvasLayer


func _on_button_morir_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	GlobalVar.vida_jugador = GlobalVar.vida_max
	cambiar_escena.recargar_escena()
	GlobalVar.puede_moverse = true

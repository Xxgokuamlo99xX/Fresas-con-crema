extends CanvasLayer


func _on_button_morir_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	cambiar_escena.recargar_escena()
	GlobalVar.vida_jugador = GlobalVar.vida_max
	GlobalVar.mana = GlobalVar.mana_max
	GlobalVar.puede_moverse = true

extends CanvasLayer

func _ready():
	$".".hide()

func _physics_process(delta):
	if Input.is_action_just_pressed("opciones"):
		_pausa()
	#print(GlobalVar.pausa)
	
func _pausa():
	if GlobalVar.pausa == false:
		$".".show()
		get_tree().paused = true
		
	elif GlobalVar.pausa == true:
		$".".hide()
		get_tree().paused = false
		
			
	GlobalVar.pausa = !GlobalVar.pausa
		
func _on_fullscreen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_button_2_pressed() -> void:
	GlobalVar.guardar_partida()
	get_tree().paused = false
	cambiar_escena.cambio_escena("res://Escenas/pantalla_de_inicio.tscn")

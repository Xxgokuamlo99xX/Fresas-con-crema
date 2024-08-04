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
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		
	elif GlobalVar.pausa == true:
		$".".hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		get_tree().paused = false
		
			
	GlobalVar.pausa = !GlobalVar.pausa
		
func _on_fullscreen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_button_2_mouse_entered() -> void:
	$botones/Button2.text = "Miedo o que"

func _on_button_2_mouse_exited() -> void:
	$botones/Button2.text = "Salir"

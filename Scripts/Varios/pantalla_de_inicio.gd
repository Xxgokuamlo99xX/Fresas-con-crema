extends Node

@warning_ignore("unused_parameter")

@onready var boton_1 : Button = $Botones/Partidas/Partida_1
@onready var boton_2 : Button = $Botones/Partidas/Partida_2
@onready var boton_3 : Button = $Botones/Partidas/Partida_3

#seccion del inicio
func borrar_partida(slot : int):
	if FileAccess.file_exists("user://Archivo de guardado"+str(slot)+".json"):
		DirAccess.remove_absolute("user://Archivo de guardado"+str(slot)+".json")
		recargar_botones()
	else:
		return
		
func cargar(slot : int):
	if FileAccess.file_exists("user://Archivo de guardado"+str(slot)+".json"):
		GlobalVar.cargar_partida(slot)
	else:
		GlobalVar.nueva_partida()
		GlobalVar.slot_actual = slot
		cambiar_escena.cambio_escena("res://Escenas/2D/niveles/Tutorial.tscn")

func recargar_botones() -> void:
	if FileAccess.file_exists("user://Archivo de guardado1.json"):
		boton_1.text = "Cargar"
	else:
		boton_1.text = "Nueva"
	
	if FileAccess.file_exists("user://Archivo de guardado2.json"):
		boton_2.text = "Cargar"
	else:
		boton_2.text = "Nueva"
		
	if FileAccess.file_exists("user://Archivo de guardado3.json"):
		boton_3.text = "Cargar"
	else:
		boton_3.text = "Nueva"

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_jugar_pressed() -> void:
	$Cameras/Partidas.priority = 2
	$Cameras/Inicio.priority = 1
	recargar_botones()
#seccion de seleccion de partidas

func _on_partida_1_pressed() -> void:
	cargar(1)

func _on_partida_2_pressed() -> void:
	cargar(2)
	
func _on_partida_3_pressed() -> void:
	cargar(3)
		
func _on_regresar_pressed() -> void:
	$Cameras/Inicio.priority = 2
	$Cameras/Partidas.priority = 1

#Seccion para borrar

func _on_borrar_1_pressed() -> void:
	borrar_partida(1)

func _on_borrar_2_pressed() -> void:
	borrar_partida(2)

func _on_borrar_3_pressed() -> void:
	borrar_partida(3)

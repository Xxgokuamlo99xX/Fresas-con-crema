extends Control

@onready var id_input = $mision/LineEdit  # LineEdit para ingresar la ID de misión
@onready var vainaeter = $eter/LineEdit


# Referencia al nodo principal o al script que maneja las misiones
#
#mision
func _on_apply_button_pressed():
	# Convertir el texto ingresado a un número entero
	var new_id = int(id_input.text)
	
	# Cambiar la ID de la misión
	Misiones.aceptar_mision(new_id)
	
	print("ID de misión cambiada a: ", new_id)


func _on_cambio_mision_boton_2_pressed() -> void:
	var eter = int(vainaeter.text)
	GlobalVar.eter += eter

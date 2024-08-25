extends Control

@onready var id_input = $LineEdit  # LineEdit para ingresar la ID de misión
@onready var apply_button = $"cambio mision boton"  # Botón para aplicar el cambio

# Referencia al nodo principal o al script que maneja las misiones
#

func _on_apply_button_pressed():
	# Convertir el texto ingresado a un número entero
	var new_id = int(id_input.text)
	
	# Cambiar la ID de la misión
	Misiones.aceptar_mision(new_id)
	
	print("ID de misión cambiada a: ", new_id)

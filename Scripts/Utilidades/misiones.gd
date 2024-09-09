extends Node

func aceptar_mision(ID_mision : int):
	# Establece la misión actual con el ID dado
	Ids.mision_act_id = ID_mision
	# Llama a la función para actualizar el nombre y resumen de la misión
	Ids.misiones_nom_resumen()
	# Actualiza las etiquetas en la interfaz de usuario


func completar_mision():
	# Establece la misión actual con el ID dado
	Ids.mision_act_id = 0
	# Llama a la función para actualizar el nombre y resumen de la misión
	Ids.misiones_nom_resumen()
	# Actualiza las etiquetas en la interfaz de usuario

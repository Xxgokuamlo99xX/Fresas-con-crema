extends CanvasLayer

@onready var Nombre_mision = $Nombre_mision_resumen/Label
@onready var res_mision = $Resumen_mision/Label2


func aceptar_mision(ID_mision : int):
	
	# Establece la misión actual con el ID dado
	Ids.mision_act_id = ID_mision
	# Llama a la función para actualizar el nombre y resumen de la misión
	Ids.misiones_nom_resumen()
	# Actualiza las etiquetas en la interfaz de usuario
	Nombre_mision.text = Ids.mision_act_nom
	res_mision.text = Ids.mision_act_res

func completar_mision():
	
	# Establece la misión actual con el ID dado
	Ids.mision_act_id = 0
	# Llama a la función para actualizar el nombre y resumen de la misión
	Ids.misiones_nom_resumen()
	# Actualiza las etiquetas en la interfaz de usuario
	Nombre_mision.text = Ids.mision_act_nom
	res_mision.text = Ids.mision_act_res
	
func _process(delta: float) -> void:
	if Ids.mision_act_id == 0:
		hide()
	else:
		show()

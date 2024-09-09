extends Control

@onready var Nombre_mision = $Nombre_mision_resumen/Label
@onready var res_mision = $Resumen_mision/Label2


func _process(delta: float) -> void:
	Nombre_mision.text = Ids.mision_act_nom
	res_mision.text = Ids.mision_act_res
	if Ids.mision_act_id == 0:
		hide()
	else:
		show()

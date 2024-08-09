extends CanvasLayer

@onready var Nombre_mision = $Nombre_mision_resumen/Label
@onready var res_mision = $Resumen_mision/Label2


func aceptar_mision(N_mision : String, resumen : String):
	
	Nombre_mision.text = N_mision
	res_mision.text = resumen
	GlobalVar.mision_actual = N_mision

func completar_mision():
	Nombre_mision.text = "Ninguna"
	GlobalVar.mision_actual = Nombre_mision.text
	

func _process(delta: float) -> void:
	if GlobalVar.mision_actual == "Ninguna":
		hide()
	else:
		show()

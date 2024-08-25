extends Node

var misiones_id : Dictionary = {
	
	0 : "NULL",
	1 : "Cueva_inicio",
	2 : "Despues",
	3 : "Desierto_1",
	4 : "Desierto_2"
	
	}
	
var mision_act_nom : String
var mision_act_res : String
var mision_act_id : int = 0
	
func misiones_nom_resumen():
	print(mision_act_id)
	match mision_act_id:
		0:
			mision_act_nom = "Ninguna"
			mision_act_res = "No tienes misiones activas"
		1:
			mision_act_nom = "La cueva."
			mision_act_res = "Ve e investiga la dichosa cueva"
		2:
			mision_act_nom = "El despues."
			mision_act_res = "Talvez termines arrestada. Nadie lo sabe"
		3:
			mision_act_nom = "El Desierto."
			mision_act_res = "Goku te mando al desierto, nada personal, hasta incluso te lo topes alla"

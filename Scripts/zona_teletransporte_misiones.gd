extends Node2D


func _process(delta: float) -> void:
	if not Ids.mision_act_id >= 3:
		return
	else:
		deteccion()
	
func deteccion():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("Jugador"):
			GlobalVar.puede_moverse = false
			cambio_escena()

		GlobalVar.nivel_anterior = get_parent().get_parent().name
	
func cambio_escena():
	var mision : StringName
	match Ids.mision_act_id:		#Aqui van los id de las misiones. tambien cambiar las rutas
		3:
			mision = "res://Escenas/2D/niveles/desierto_lvl(1).tscn"
			cambiar_escena.cambio_escena(mision)
			

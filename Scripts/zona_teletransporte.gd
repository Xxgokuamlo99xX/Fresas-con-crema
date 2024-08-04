extends Node2D

@export var escena_cambio : StringName

func _process(delta: float) -> void:
	deteccion()
			
func cambio_de_escena():
	cambiar_escena.cambio_escena(escena_cambio)

func deteccion():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("Jugador"):
			GlobalVar.puede_moverse = false
			cambio_de_escena()

		GlobalVar.nivel_anterior = get_parent().get_parent().name

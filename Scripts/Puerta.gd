extends Node2D

@onready var sprite : Sprite2D = $Sprite2D
@export var escena_cambio : StringName

func _process(delta: float) -> void:
	deteccion()
			
func cambio_de_escena():
	cambiar_escena.cambio_escena(escena_cambio)

func deteccion():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("Jugador"):
			sprite.show()
			if Input.is_action_just_pressed("usar"):
				GlobalVar.puede_moverse = false
				cambio_de_escena()
		else:
			sprite.hide()
		GlobalVar.nivel_anterior = get_parent().get_parent().name

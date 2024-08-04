extends Node2D

@export var Timeline_ : DialogicTimeline
@export var area2d : Area2D
@export var noti_de_uso : Sprite2D
var hablando : bool = false

	
func _process(delta: float) -> void:
	for body in area2d.get_overlapping_bodies():
		if body.is_in_group("Jugador"):
			if Input.is_action_just_pressed("usar") && hablando == false:
				
				GlobalVar.puede_moverse = false
				Dialogic.start(Timeline_)
				hablando = true
				await Dialogic.timeline_ended  
				await get_tree().create_timer(1.0).timeout
				hablando = false
				GlobalVar.puede_moverse = true
				
			if hablando == false:
				noti_de_uso.show()
		else:
			noti_de_uso.hide()
func loasd():
	pass

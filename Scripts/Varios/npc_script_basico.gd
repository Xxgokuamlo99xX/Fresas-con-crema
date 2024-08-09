extends Node2D

@export var Timeline_ : DialogicTimeline
@export var area2d : Area2D
@export var noti_de_uso : Sprite2D
@export var cofre : bool
@export var recompensa : int
var hablando : bool = false

	
func _process(delta: float) -> void:
	for body in area2d.get_overlapping_bodies():
		if body.is_in_group("Jugador"):
			if Input.is_action_just_pressed("usar") && hablando == false:
				body.state_machine.travel("Idle")
				hablar()
				if cofre == true:
					Dialogic.VAR.Cant_loot = recompensa
					await Dialogic.timeline_ended  
					GlobalVar.puede_moverse = true
					queue_free()
					
			if hablando == false:
				noti_de_uso.show()
		else:
			noti_de_uso.hide()

func hablar():
	GlobalVar.puede_moverse = false
	Dialogic.start(Timeline_)
	hablando = true
	await Dialogic.timeline_ended  
	await get_tree().create_timer(1.0).timeout
	hablando = false
	GlobalVar.puede_moverse = true
	

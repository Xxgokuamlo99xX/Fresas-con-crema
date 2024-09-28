extends Node2D

@export_category("Comun")
@export var Timeline_ : DialogicTimeline
@export var area2d : Area2D
@export var noti_de_uso : Sprite2D
@export var nombre_obj : String
@export var unlocks : Node

@export_category("cofre")
@export var cofre : bool
@export var tipo_rec : loot_posible
@export var Cant_recompensa : int 

@export_category("Objeto de tienda")
@export var Obj_tienda : bool
@export var precio : int


enum loot_posible {eter,contenerdor_corazon,mas_mana,mejora_damage,hechizo}

var hablando : bool = false

	
func _process(delta: float) -> void:
	for body in area2d.get_overlapping_bodies():
		if body.is_in_group("Jugador"):
			if Input.is_action_just_pressed("usar") && hablando == false:
				body.state_machine.travel("Idle")
				hablar()
				if cofre:
					Dialogic.VAR.Cant_loot = Cant_recompensa
					Dialogic.VAR.Tipo_loot = nombre_obj
					await Dialogic.timeline_ended 
					recompesa()
					GlobalVar.puede_moverse = true
					queue_free()
					
				if Obj_tienda:
					Dialogic.VAR.Tipo_loot = nombre_obj
					Dialogic.VAR.Precio = precio
					await Dialogic.timeline_ended
					if GlobalVar.eter >= precio:
						recompesa()
						GlobalVar.eter -= precio
						GlobalVar.puede_moverse = true
						queue_free()
					else:
						return
						
			if hablando == false:
				noti_de_uso.show()
		else:
			noti_de_uso.hide()

func hablar():
	GlobalVar.puede_moverse = false
	Dialogic.start(Timeline_)
	hablando = true
	await Dialogic.timeline_ended  
	await get_tree().create_timer(0.7).timeout
	hablando = false
	GlobalVar.puede_moverse = true
	
func recompesa(): # ("eter", "contenedor_corazon", "Mana_max")
	match tipo_rec:
		loot_posible.eter:
			GlobalVar.eter += Cant_recompensa
			
		loot_posible.contenerdor_corazon:
			GlobalVar.vida_max += 20
			GlobalVar.vida_jugador = GlobalVar.vida_max
			
		loot_posible.mas_mana:
			GlobalVar.mana_max += 50
			GlobalVar.mana = GlobalVar.mana_max	
			
		loot_posible.mejora_damage:
			GlobalVar.multi_damage += 0.5
			
		loot_posible.hechizo:
			unlocks.desbloqueo()

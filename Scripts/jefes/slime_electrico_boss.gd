extends "res://Scripts/jefes/boss_estatico.gd"


var rayo = preload("res://Escenas/2D/Enemigos/trueno.tscn").instantiate()
var bola_alectrica = preload("res://armas/esfera_electrica.tscn").instantiate()

@export var vida_max : int
@onready var jugador = get_parent().get_node("Goku")
@onready var state_machine = $AnimationPlayer

func _process(delta: float) -> void:
	ataques()
	
func ataques():
	if tiempo_ataque.is_stopped():
		match randi_range(1, 4):
			1:
				state_machine.play("Ataque_1")
				
			2:
				state_machine.play("Ataque_2")
				
			3:
				state_machine.play("Ataque_3")
				
			4:
				state_machine.play("Ataque_4")

func iniciar_timer():
	tiempo_ataque.start()
		
func ataque_1():
	hitbox.monitorable = false
	hitbox.monitorable = true
	
func ataque_2(atak_cant : int):
	while atak_cant != 0:
		atak_cant -= 1
		var rayo_copia = rayo.duplicate()
		rayo_copia.position = jugador.position
		get_parent().add_child(rayo_copia)
		await get_tree().create_timer(0.5).timeout
		
func ataque_3(atak_cant : int, velocidad : int):
	while atak_cant != 0:
		atak_cant -= 1
		var bola_copia = bola_alectrica.duplicate()
		bola_copia.position = position
		bola_copia.objetivo = jugador
		get_parent().add_child(bola_copia)
		bola_copia.velocidad = velocidad
		
		await get_tree().create_timer(1).timeout

func ataque_4(atak_cant : int, velocidad : int):
	while atak_cant != 0:
		atak_cant -= 1
		var bola_copia = bola_alectrica.duplicate()
		bola_copia.position = position
		bola_copia.objetivo = jugador
		get_parent().add_child(bola_copia)
		bola_copia.guiada = false
		bola_copia.velocidad = velocidad
		
		await get_tree().create_timer(1).timeout
	
func _on_hurbo_body_entered(body: Node2D) -> void:
	if body.is_in_group('Jugador'):
		GlobalVar.player_damage_taken = damage
		body._damage()

func acabar_ataque():
	state_machine.play("nada")

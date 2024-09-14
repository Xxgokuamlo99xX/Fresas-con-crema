extends CharacterBody2D

#TODO Agregar colisiones a los ataques, hacer enemigos y ya 
var inmortal : bool = false

@export var SPEED : int = 150
@export var GRAVITY : float = 9.8
@export var JUMP_FORCE : int = 250  
var ataque_num : int = 3
@export var damage : int = 5 * GlobalVar.multi_damage

@onready var hechizo = $Voltear/Hechizo
@onready var hitobx_arma = $Voltear/Hitbox_arma
@onready var state_machine_2 = $AnimationTree
var dir = Vector2.ZERO
var state_machine
var fps
var rotacion : float
signal recive_damage
signal curarse 
signal morixd


var arma_actual : int = 0
var bola_fuego = preload("res://armas/Bola_de_fuego.tscn")
var bola_fuego_azul = preload("res://armas/bola_fuego_azul.tscn")
var pantalla_de_muerte = preload("res://Scripts/Jugador/cosas_muerte.gd").new()

var armas : Array

func _physics_process(delta):
	flip()
	$Movimiento.recividor_inputs()
	
func _ready():
	
	$AnimationTree.active = true
	state_machine = $AnimationTree.get("parameters/playback")
	armas = [bola_fuego, bola_fuego_azul]
	
func animaciones():
	#Correr
	if velocity.x != 0:
		state_machine.travel("Correr")
		
	else:
		state_machine.travel("Idle")
		
	#Salto
	if not is_on_floor():
		if velocity.y < 0:
			state_machine.travel("Salto_inicio")
		else:
			state_machine.travel("Caida")
		
	#Ataque_magico
	if InputBuffer.is_action_press_buffered("Ataque_magico") && GlobalVar.mana != 0 && is_on_floor():
		await get_tree().create_timer(0.01).timeout
		state_machine.travel("Ataque_magico")
		GlobalVar.puede_moverse = false
		await $AnimationTree.animation_finished
		GlobalVar.puede_moverse = true
		
	#Ataque_melee - Ataques consecutivos
	if InputBuffer.is_action_press_buffered("Ataque_melee") && is_on_floor():
		
		await get_tree().create_timer(0.01).timeout
		match ataque_num:
			3:
				ataque_num -= 1
				damage = damage * 1
				state_machine.travel("Ataque_1")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				GlobalVar.puede_moverse = true
				
			2:
				ataque_num -= 1
				damage = damage * 2
				state_machine.travel("Ataque_2")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				GlobalVar.puede_moverse = true
				
			1:
				ataque_num = 3 
				damage = damage * 3
				state_machine.travel("Ataque_3")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				GlobalVar.puede_moverse = true
	damage = 5 * GlobalVar.multi_damage

func flip():
	if dir.x == -1:
		$Voltear.scale = Vector2(-1,1)
		rotacion = 180
	elif dir.x == 1:
		$Voltear.scale = Vector2(1,1)
		rotacion = 0

func _damage():
	if $Invulnerable.is_stopped() and not inmortal:
		$Invulnerable.start()
		GlobalVar.vida_jugador -= GlobalVar.player_damage_taken
		$Invulnerable/AnimationPlayer.play("invul_time")
		$"Daño_pupap"._pupa()
		if GlobalVar.vida_jugador <= 0:
			inmortal = true
			GlobalVar.puede_moverse = false
			state_machine.travel("morir")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			await $animaciones.animation_finished
			

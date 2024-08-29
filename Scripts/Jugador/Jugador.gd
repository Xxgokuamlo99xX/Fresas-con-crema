extends CharacterBody2D

#TODO Agregar colisiones a los ataques, hacer enemigos y ya 

@export var SPEED : int = 150
@export var GRAVITY : float = 9.8
@export var JUMP_FORCE : int = 250  
var ataque_num : int = 3
@export var damage : int = 5

@onready var hechizo = $Voltear/Hechizo
@onready var hitobx_arma = $Voltear/Hitbox_arma
@onready var state_machine_2 = $AnimationTree
var dir = Vector2.ZERO
var state_machine
var fps
var rotacion : float
signal recive_damage
signal curarse 
signal ataque_magia
signal morixd


var arma_actual : int = 0
var bola_fuego = preload("res://armas/Bola_de_fuego.tscn")
var bola_fuego_azul = preload("res://armas/bola_fuego_azul.tscn")


var armas : Array

func _physics_process(delta):
	flip()
	recargar_mana()
	recividor_inputs()
	cambiar_hechizo()
	
	velocity.y = clampf(velocity.y,-240,240)

func Ataque():   # Esta funcion se llama en el anim_player del jugador
	match arma_actual:
		0:
			hechizo.shoot(200,10,rotacion)
			
		1:
			hechizo.shoot(300,20,rotacion)
			
	ataque_magia.emit() # Nose si funcione cambiandolo por un await get_tree().create_timer().timeout
		
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
				damage = 5
				state_machine.travel("Ataque_1")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				GlobalVar.puede_moverse = true
				
			2:
				ataque_num -= 1
				damage = 10
				state_machine.travel("Ataque_2")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				GlobalVar.puede_moverse = true
				
			1:
				ataque_num = 3 
				damage = 15
				state_machine.travel("Ataque_3")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				GlobalVar.puede_moverse = true

func flip():
	if dir.x == -1:
		$Voltear.scale = Vector2(-1,1)
		rotacion = 180
	elif dir.x == 1:
		$Voltear.scale = Vector2(1,1)
		rotacion = 0
	
func recividor_inputs():
	if GlobalVar.puede_moverse == true:
		dir.x = Input.get_action_strength("move_der") - Input.get_action_strength("move_izq")
		
		if InputBuffer.is_action_press_buffered("salto") and is_on_floor():
				velocity.y -= JUMP_FORCE 
				
		velocity.x = dir.x * SPEED
		velocity.y += GRAVITY 
		move_and_slide()
		animaciones()
	else:
		velocity = Vector2.ZERO
		
func _damage():
	if $Invulnerable.is_stopped():
		$Invulnerable.start()
		GlobalVar.vida_jugador -= GlobalVar.player_damage_taken
		$Invulnerable/AnimationPlayer.play("invul_time")
		$"Daño_pupap"._pupa()
		if GlobalVar.vida_jugador <= 0:
			GlobalVar.puede_moverse = false
			state_machine.travel("morir")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			await $animaciones.animation_finished
			queue_free()

	
func _on_curarse() -> void:
	$curarse.play()

func cambiar_hechizo():
	
	if Input.is_action_just_pressed("arma_anterior"): 
		arma_actual -= 1
		if arma_actual < 0:
			arma_actual = 1
		hechizo.bullet = armas[arma_actual]
		
	elif Input.is_action_just_pressed("arma_siguiente"):
		arma_actual += 1
		if arma_actual > 1:
			arma_actual = 0
		hechizo.bullet = armas[arma_actual]
		
func recargar_mana():
	if $"mana cooldown".is_stopped() && GlobalVar.mana != 100:
		GlobalVar.mana += 1

func _on_ataque_magia() -> void:
	$"mana cooldown".start()

func _on_hitbox_arma_area_entered(area: Area2D) -> void:
	GlobalVar.enemigo_damage_taken = damage
	area.get_parent().sus()
	

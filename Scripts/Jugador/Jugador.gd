extends CharacterBody2D

#TODO Agregar colisiones a los ataques, hacer enemigos y ya 
var inmortal : bool = false

@export var SPEED : int = 150
@export var GRAVITY : float = 9.8
@export var JUMP_FORCE : int = 250  
var ataque_num : int = 3
@export var damage : int = 2 * GlobalVar.multi_damage

@onready var hechizo := $Voltear/Hechizo
@onready var hitobx_arma := $Voltear/Hitbox_arma
@onready var state_machine_2 := $AnimationTree
@onready var ataq_coldwn := $Ataque_cooldown
var dir = Vector2.ZERO
var state_machine
var fps
var rotacion : float
signal recive_damage
signal curarse 
signal morixd

var pantalla_de_muerte = preload("res://Scripts/Jugador/cosas_muerte.gd").new()
@export var hcz_res : Hechizos


func _physics_process(delta):
	flip()
	$Movimiento.recividor_inputs()
	if Input.is_action_just_pressed("habilida_1"):
		cambio_hecz(GlobalVar.bola_fuego)
	elif Input.is_action_just_pressed("habilida_2"):
		cambio_hecz(GlobalVar.bola_electrica)
		
func _ready():
	cambio_hecz(hcz_res)
	$AnimationTree.active = true
	state_machine = $AnimationTree.get("parameters/playback")
	
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
		
	checar_ataque()
	#Ataque_melee - Ataques consecutivos
	if InputBuffer.is_action_press_buffered("Ataque_melee") && is_on_floor() && ataq_coldwn.is_stopped():
		
		await get_tree().create_timer(0.01).timeout
		match ataque_num:
			3:
				ataque_num -= 1
				damage = damage * 1
				state_machine.travel("Ataque_1")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				ataq_coldwn.start()
				GlobalVar.puede_moverse = true
				
			2:
				ataque_num -= 1
				damage = damage * 2
				state_machine.travel("Ataque_2")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				ataq_coldwn.start()
				GlobalVar.puede_moverse = true
				
			1:
				ataque_num = 3 
				damage = damage * 3
				state_machine.travel("Ataque_3")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				ataq_coldwn.start()
				GlobalVar.puede_moverse = true
	damage = 2 * GlobalVar.multi_damage

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
			
func ataques_magicos_anim():
		#Ataque_magico
		if InputBuffer.is_action_press_buffered("Ataque_magico") && GlobalVar.mana != 0 && is_on_floor():
			if GlobalVar.mana >= hcz_res.mana_cost:
				GlobalVar.mana -= hcz_res.mana_cost
				await get_tree().create_timer(0.01).timeout
				state_machine.travel("Ataque_magico")
				GlobalVar.puede_moverse = false
				await $AnimationTree.animation_finished
				GlobalVar.puede_moverse = true
			else:
				return
		else:
			return

func checar_ataque():
	if GlobalVar.tiene_magia:
		ataques_magicos_anim()
	else:
		return

func cambio_hecz(hechizo_cambio : Resource):
	hcz_res = hechizo_cambio
	hechizo.bullet = hcz_res.bala_base

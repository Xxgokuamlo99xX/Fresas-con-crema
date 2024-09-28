extends CharacterBody2D

@export_category("Utiles")

@export var raycast : RayCast2D
@export var marker : Marker2D
@export var invul : Timer
@onready var sprite : AnimationPlayer = $AnimationPlayer
@export var hurbo : Area2D
@export var hitbox : Area2D

@export_category("Stats")

@export var vida : int = 20
@export var damage : int = 10
@export var velocidad : int = 50
@export var defensa : int = 1

var probabilidad : int = randi_range(1,2)
@export var loot : Array [PackedScene]

var dir : int 
var gravedad : float = 9.8
var puede_moverse : bool = true


func _physics_process(delta: float) -> void:
	if vida <= 0:
		hurbo.monitoring = false
		hurbo.monitorable = false
		hitbox.monitorable = false
		puede_moverse = false
		invul.start()
		sprite.play("morir")
		await sprite.animation_finished
		queue_free()
		
	if puede_moverse == false:
		velocity = Vector2.ZERO 
			
	else:
		moverse()
		cambio_dir()
	
func moverse():
	velocity.x = velocidad
	velocity.y += gravedad
	sprite.play("caminar")
	move_and_slide()

func cambio_dir():
	if is_on_wall() || not raycast.is_colliding():
		scale.x *= -1 
		velocidad *= -1 

func enemigo_hit():
	if invul.is_stopped():
		puede_moverse = false
		invul.start()
		vida -= (GlobalVar.enemigo_damage_taken / defensa)
		marker._pupa()
		sprite.play("hit")
		await $AnimationPlayer.animation_finished
		puede_moverse = true
		if vida <= 0:
			soltar_loot()
		
func soltar_loot():
	var lut_soltado
	if probabilidad == 2:
		if GlobalVar.vida_jugador != GlobalVar.vida_max:
			lut_soltado = loot[1].instantiate()
			
		else:
			match randi_range(1,2):
				1:
					lut_soltado = loot[0].instantiate()
				2:
					lut_soltado = loot[2].instantiate()
				
		lut_soltado.global_position = global_position
		get_parent().add_child(lut_soltado)
		
func _on_hurbo_body_entered(body: Node2D) -> void:
	if body.is_in_group('Jugador'):
		GlobalVar.player_damage_taken = damage
		body._damage()

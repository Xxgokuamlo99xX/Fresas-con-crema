extends CharacterBody2D

@export var raycast : RayCast2D
@export var marker : Marker2D
@export var invul : Timer
@export var sprite : AnimatedSprite2D
@export var hurbo : Area2D
@export var hitbox : Area2D


@export var vida : int = 20
@export var damage : int = 10
@export var velocidad : int = 50                                                                                                                                                                                                                                             
var probabilidad : int = randi_range(1,2)
@export var loot : Array [PackedScene]

var dir : int 
var gravedad : float = 9.8


func _physics_process(delta: float) -> void:
	if vida <= 0:
		hurbo.monitorable = false
		hurbo.monitoring = false
		hitbox.monitorable = false
		hitbox.monitoring = false
		velocity = Vector2.ZERO
		sprite.play("morir")
		await sprite.animation_finished
		queue_free()
		
	if not invul.is_stopped():
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

func sus():
	if invul.is_stopped():
		invul.start()
		vida -= GlobalVar.enemigo_damage_taken
		marker._pupa()
		sprite.play("golpe")
		if vida <= 0:
			soltar_loot()
		
func soltar_loot():
	var lut_soltado
	if probabilidad == 2:
		if GlobalVar.vida_jugador == GlobalVar.vida_max:
			lut_soltado = loot[0].instantiate()
			
		else:
			lut_soltado = loot[1].instantiate()
			
		lut_soltado.global_position = global_position
		get_parent().add_child(lut_soltado)
		
func _on_hurbo_body_entered(body: Node2D) -> void:
	if body.is_in_group('Jugador'):
		GlobalVar.player_damage_taken = damage
		body._damage()

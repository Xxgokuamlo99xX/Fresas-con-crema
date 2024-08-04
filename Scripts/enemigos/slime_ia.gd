extends CharacterBody2D

@export var colision : CollisionShape2D
@export var hitbox : Area2D
@export var raycast : RayCast2D
@export var invul : Timer

@export var vida : int = 20
@export var damage : int = 10
@export var velocidad : int = 50                                                                                                                                                                                                                                             
@export var rango : int 

var dir : int 
var gravedad : float = 9.8


func _physics_process(delta: float) -> void:
	if not invul.is_stopped():
		velocity = Vector2.ZERO 
	else:
		moverse()
		cambio_dir()

func moverse():
	velocity.x = velocidad
	velocity.y += gravedad
	move_and_slide()

func cambio_dir():
	if is_on_wall() || not raycast.is_colliding():
		scale.x *= -1 
		velocidad *= -1 

func sus():
	if invul.is_stopped():
		invul.start()
		vida -= GlobalVar.enemigo_damage_taken
		$Marker2D._pupa()
		if vida <= 0:
				velocity = Vector2.ZERO
				queue_free()


func _on_hurbo_body_entered(body: Node2D) -> void:
	if body.is_in_group('Jugador'):
		GlobalVar.player_damage_taken = damage
		body._damage()

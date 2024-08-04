extends CharacterBody2D

const Speed = 60
var direction = 1

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var animation_enemigo = $AnimatedSprite2D

func _process(delta):
	animation_enemigo.play("Run")
	if ray_cast_right.is_colliding():
		direction = -1 
		animation_enemigo.flip_h = true
	if ray_cast_left.is_colliding():
		direction = +1
		animation_enemigo.flip_h = false
	position.x += direction * Speed * delta 

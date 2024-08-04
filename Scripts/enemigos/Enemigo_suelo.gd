extends CharacterBody2D

@export var speed = 100
@export var nav_agent: NavigationAgent2D
@export var damage_touch = 10
@export var damage_attack = 30
@export var life : int = 30
var target_node = null
var home_pos = Vector2.ZERO
var pisando : bool = true
var gravity = 9.8
var axis 
var dir = Vector2.ZERO
var atacando : bool = false
var state_machine
signal me_dieron_enemigo

func _ready():
	home_pos = self.global_position
	nav_agent.path_desired_distance = 10
	nav_agent.target_desired_distance = 10
	$AnimationTree.active = true
	state_machine = $AnimationTree.get("parameters/playback")
func _physics_process(_delta):
	
	if nav_agent.is_navigation_finished():
		return
	axis = to_local (nav_agent.get_next_path_position()).normalized()
	#dir.snapped(velocity)
	flip()
	anims()
	morir()
	_parar()
	move_and_slide()
	#print(dir)
	print(velocity.x)
	
func recalc_path():
	if target_node:
		nav_agent.target_position = target_node.global_position
	else:#if target_node.dir.y >= 1:
		nav_agent.target_position = home_pos

func _on_timer_timeout():
	recalc_path()

func _on_deteccion_zone_body_entered(body):
	target_node = body
	print(body)

func _on_deteccion_zone_exit_body_exited(body):
	if body == target_node:
		target_node = null
		
	print(body)

func _parar():
	
	pisando = $voltear/RayCast2D.is_colliding()
	
	if pisando == false && is_on_floor():
		velocity = Vector2(0,0)
	else:
		velocity.x = axis.x * speed
		velocity.y += gravity

func flip():
	
	if axis.x < 0: 
		$voltear.scale.x = abs(scale.x) * -1
	else:
		$voltear.scale.x = abs(scale.x) 

func anims():
	
	if $voltear/attack_indicator.is_colliding() && atacando == false:
		$AnimationPlayer.play("ataque")
		axis = Vector2(0,0)
	else:
		if axis.x != 0:
			$AnimationPlayer.play("correr")
		else:
			$AnimationPlayer.play("idle")

func morir():
	if life <= 0:
		state_machine.travel("morir")
		axis = Vector2(0,0)
		#target_node = null
		
func _on_me_dieron_enemigo() -> void:
	$Marker2D._pupa()
	$efectos/AnimationPlayer.play("damage")

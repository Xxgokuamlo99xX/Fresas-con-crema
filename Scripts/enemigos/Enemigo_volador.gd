extends CharacterBody2D

@export var speed = 75
@export var nav_agent: NavigationAgent2D
@export var damage = 10
@export var life : int = 100
var target_node = null
var home_pos = Vector2.ZERO
signal me_dieron_enemigo
var axis
var loot_corazon = preload("res://Escenas/vainas/corazon.tscn")
var cora = loot_corazon.instantiate()


func _ready():
	home_pos = self.global_position
	#$AnimatedSprite2D.play("idle")
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	

func _physics_process(_delta):
	#print(target_node)
	
	if nav_agent.is_navigation_finished():
		return
	
	axis = to_local (nav_agent.get_next_path_position()).normalized()
	velocity = axis * speed
	if life <= 0:
		velocity = Vector2(0,0)
	move_and_slide()
	if global_position == home_pos:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("volar")

func recalc_path():

	if target_node:
		nav_agent.target_position = target_node.global_position
		
	else:
		nav_agent.target_position = home_pos

func _on_timer_timeout():
	recalc_path()

func _on_deteccion_zone_body_entered(body):
	target_node = body
	
	print("entre")

func _on_deteccion_zone_exit_body_exited(body):
	if body == target_node:
		target_node = null
	print("sali")
	
func morir():
	if life <= 0:
		velocity = Vector2(0,0)
		cora.position = position
		GlobalVar.puntos += 100
		get_parent().add_child(cora)
		
func _on_me_dieron_enemigo() -> void:
	$Marker2D._pupa()
	$efectos/AnimationPlayer.play("damage")
	if life <= 0:
		$efectos/AnimationPlayer.play("morir")
		velocity = Vector2(0,0)
		morir()

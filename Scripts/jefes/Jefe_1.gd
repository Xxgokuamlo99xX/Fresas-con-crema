extends CharacterBody2D

@export var speed = 20
@export var damage= 10
@export var life : int 
signal me_dieron_enemigo
var axis
var lugar_de_apuntado
var win = preload("res://Escenas/vainas/win screen.tscn")

func _ready():
		$AnimatedSprite2D.play("volar")
	
func _physics_process(_delta):
	disparo()
	morir()
	GlobalVar.current_boss_life = life

func morir():
	if life <= 0:
		velocity = Vector2(0,0)
		GlobalVar.puntos += 1000
		get_parent().add_child(win.instantiate())
		GlobalVar.boss_1_alive = false
		
		
func _on_me_dieron_enemigo() -> void:
	$Marker2D._pupa()
	$efectos/AnimationPlayer.play("damage")
	if life <= 0:
		$efectos/AnimationPlayer.play("morir")
		velocity = Vector2(0,0)

#func _on_deteccion_body_entered(body: Node2D) -> void:
	#pass

func disparo():
	for body in $deteccion.get_overlapping_bodies():
		if body.is_in_group("Jugador"):
			lugar_de_apuntado = body.global_position
			$Gun.look_at(lugar_de_apuntado)
			if life <= 500 && life >= 400:
				$Gun.shoot(100,$Gun.rotation_degrees)
				$Gun.NBS = 3
				$Gun.CoolDown = 6
				
				
			elif life <= 400 && life >= 150:
				$Gun.shoot(150,$Gun.rotation_degrees)
				$Gun.NBS = 5
				$Gun.CoolDown = 5
				
			elif life <= 150:
				$Gun.shoot(150,$Gun.rotation_degrees)
				$Gun.NBS = 5
				$Gun.CoolDown = 4
				
		

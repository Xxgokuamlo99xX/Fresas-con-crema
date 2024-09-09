extends CharacterBody2D

@export_category("Utiles")

@export var marker : Marker2D
@export var invul : Timer
@onready var sprite : AnimationPlayer = $AnimationPlayer
@export var hurbo : Area2D
@export var hitbox : Area2D
@export var tiempo_ataque : Timer

@export_category("Stats")

@export var vida : int = 20
@export var damage : int = 10

var puede_atacar : bool = true

func _physics_process(delta: float) -> void:
	if vida <= 0:
		hurbo.monitoring = false
		hurbo.monitorable = false
		hitbox.monitorable = false
		puede_atacar = false
		sprite.play("morir")
		await sprite.animation_finished
		queue_free()


func enemigo_hit():
	if invul.is_stopped():
		invul.start()
		vida -= GlobalVar.enemigo_damage_taken
		marker._pupa()

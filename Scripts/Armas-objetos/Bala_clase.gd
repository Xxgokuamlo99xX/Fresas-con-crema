extends Area2D
class_name Bullet
## A node used for [Gun]
##
## This node is used for [Gun], acts like a bullet with configurable speed and angle( for gun )
@export_category("Bullet")
#signal
## The time in seconds where this bullet is deleted
@export var delete_after : int = 30 
@export var recurso_hcz : Hechizos

## speed of the bullet in pixels per second
var speed : float

## angle of the bullet when fired
var angle : float

## used to track time for [delete_after], best not to change it to avoid errors
var time = 0
@onready var anim_sprite := $AnimatedSprite2D
var damage : int 
var mana_cost : int
var sprites : SpriteFrames

func _ready():
	anim_sprite.sprite_frames = sprites
	anim_sprite.play("default")
	if delete_after == 0:
		var screen_checker = VisibleOnScreenNotifier2D.new()
		add_child(screen_checker)
		screen_checker.connect("screen_exited()",on_screen_exited)

func _physics_process(delta: float) -> void:
		rotation_degrees = angle
		position += (Vector2.from_angle(rotation) * speed) * delta
		deteccion()
		if delete_after > 0:
			time += delta
			if time >= delete_after:
				queue_free()
				
func on_screen_exited():
	queue_free()
	
func deteccion():
	for body in get_overlapping_bodies():
		hit(body)
		queue_free() 
	for area in get_overlapping_areas():
		hit(area)
		queue_free() 
		
func hit(area):
	if area.is_in_group("enemigo"):
		GlobalVar.enemigo_damage_taken = damage
		area.get_parent().enemigo_hit()
		print("hola")
		

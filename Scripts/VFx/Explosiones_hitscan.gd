extends Area2D
class_name explosion_base

@export var damage : int


func deteccion():
	for body in get_overlapping_bodies():
		hit(body)
	for area in get_overlapping_areas():
		hit(area)
		
func hit(area):
	if area.is_in_group("Enemigos"):
		area.life -= damage
		GlobalVar.enemigo_damage_taken = damage
		area.me_dieron_enemigo.emit()
		
	queue_free() 

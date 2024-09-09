extends Node

@export var jugador : CharacterBody2D



func Ataque():   # Esta funcion se llama en el anim_player del jugador
				 #.shoot() pide velocidad, coste mana, rotacion
	jugador.hechizo.shoot(200,25,jugador.rotacion)
	
			
func _on_hitbox_arma_area_entered(area: Area2D) -> void:
	GlobalVar.enemigo_damage_taken = jugador.damage
	area.get_parent().enemigo_hit()
	

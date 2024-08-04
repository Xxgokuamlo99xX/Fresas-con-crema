extends Node2D

func _on_area_de_combate_area_entered(area):
	$"Area de Combate/Enemigo camara".set_priority(10)
	
func _on_area_de_combate_area_exited(area):
	$"Area de Combate/Enemigo camara".set_priority(0)
	

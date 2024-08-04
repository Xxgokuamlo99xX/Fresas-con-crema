extends Bullet
class_name proyectil_magico

var explosion = preload("res://Escenas/VFX/fuego_explosion.tscn")
func _physics_process(delta: float) -> void:
	basicos(delta)
	
func explotar(explosion):
	var fuegoexp = explosion.instantiate() 
	fuegoexp.top_level = true
	fuegoexp.position = position
	get_parent().get_child(1).add_child(fuegoexp)
	
	#await explosion.acabe == true
	#queue_free()
func _on_tree_exiting() -> void:
	explotar(explosion)
	
func basicos(delta):
	deteccion()
	movimiento(delta)

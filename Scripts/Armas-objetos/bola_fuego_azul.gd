extends proyectil_magico


func _ready() -> void:
	explosion = preload("res://Escenas/VFX/Fuego azul/fuego_azul_explosion.tscn")

func _physics_process(delta: float) -> void:
	basicos(delta)
	

func _on_tree_exiting() -> void:
	explotar(explosion)

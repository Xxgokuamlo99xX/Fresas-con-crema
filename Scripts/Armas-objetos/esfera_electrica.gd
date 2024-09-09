extends Node2D

var objetivo 
var velocidad : int
var guiada : bool = true
var target_direction


func _process(delta: float) -> void:
	if guiada:
		perseguir(delta)
	else:
		normal(delta)
	await get_tree().create_timer(7).timeout
	queue_free()
	
func _ready() -> void:
	target_direction = (objetivo.position - position).normalized()
	
func perseguir(delta : float):
	var seguimiento = (objetivo.position - position).normalized()
	position += seguimiento * velocidad * delta
	
func normal(delta : float):
	position += target_direction * velocidad * delta
	

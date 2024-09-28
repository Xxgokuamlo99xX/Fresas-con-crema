extends Control

@export var target : CharacterBody2D
@onready var barra : TextureProgressBar = $ProgressBar

func _process(delta: float) -> void:
	barra.max_value = target.vida_max
	barra.value = target.vida

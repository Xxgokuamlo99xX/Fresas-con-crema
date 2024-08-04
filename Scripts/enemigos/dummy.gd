extends CharacterBody2D

@export var life : int = 100000000
signal me_dieron_enemigo
@onready var invulnerable = $invulnerable

func _process(delta: float) -> void:
	$Label.text = "Vida: " + str(life)
	
func _on_me_dieron_enemigo() -> void:
	if invulnerable.is_stopped():
		$Marker2D._pupa()
		invulnerable.start()
	
	

extends Marker2D

func _ready() -> void:
	$Label.text = str(GlobalVar.player_damage_taken)

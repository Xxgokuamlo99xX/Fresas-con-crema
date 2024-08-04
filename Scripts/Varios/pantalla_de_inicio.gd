extends Node2D



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/2D/niveles/debug_nivel.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()

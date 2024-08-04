extends Node3D

func _ready():
	
	$AnimationPlayer.play("flotar")
	
func _on_area_3d_body_entered(body):
	print("toque")
	#print(GlobalVar.chatarra_count)
	GlobalVar.chatarra_count += 10
	

extends Area2D

@export var phantom_camera2D: PhantomCamera2D
var camera : Camera2D
var group_nodes


@export var shake: bool = false
var should_shake: bool = false

func _ready():
	camera = get_tree().get_first_node_in_group("Camera") as Camera2D
	body_entered.connect(actor_entered)
	body_exited.connect(actor_exited)
	
	
func _process(delta: float) -> void:
	# Based on Colision Layers
	group_nodes = phantom_camera2D.get_follow_targets()
	if should_shake:
		shake_camera()
		should_shake = false

func actor_entered(body):
	#print("entre enemigo" )
	#print(body)
	print(group_nodes)
	phantom_camera2D.set_priority(10)
	#print("hola")

	if phantom_camera2D.get_follow_mode() == 3:
		phantom_camera2D.append_follow_targets(body)
			

	if shake:
		should_shake = true

func actor_exited(body):
	#print("salio enemigo")
	#print(body)
	print(group_nodes)
	phantom_camera2D.set_priority(0)
	#print("hola")
	if phantom_camera2D.get_follow_mode() == 3 :
		phantom_camera2D.erase_follow_targets(body)

func shake_camera():
	# Código para sacudir la cámara
	pass

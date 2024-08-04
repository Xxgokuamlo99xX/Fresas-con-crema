extends Bullet

func _ready():
	if delete_after == 0:
		var screen_checker = VisibleOnScreenNotifier2D.new()
		add_child(screen_checker)
		screen_checker.connect("screen_exited()",on_screen_exited)
func _physics_process(delta):
	rotation_degrees = angle
	position += (Vector2.from_angle(rotation) * speed) * delta
	if delete_after > 0:
		time += delta
		if time >= delete_after:
			queue_free()
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemigos"):
		body.life -= damage
		print("di")
		body.me_dieron_enemigo.emit()
		GlobalVar.enemigo_damage_taken = damage
		queue_free()
	if body.is_in_group("Jugador"):
		GlobalVar.player_damage_taken = damage
		body.recive_damage.emit()
		queue_free()
		
	else:
		queue_free()
		


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemigos"):
		area.life -= damage
		print("di")
		area.me_dieron_enemigo.emit()
		GlobalVar.enemigo_damage_taken = damage
		queue_free()
	if area.is_in_group("Jugador"):
		GlobalVar.player_damage_taken = damage
		area.recive_damage.emit()
		queue_free()
		
	else:
		queue_free()

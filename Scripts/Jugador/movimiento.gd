extends Node

@export var jugador : CharacterBody2D
	
func recividor_inputs():
	if GlobalVar.puede_moverse == true:
		jugador.dir.x = Input.get_action_strength("move_der") - Input.get_action_strength("move_izq")
 
				
		jugador.velocity.x = jugador.dir.x * jugador.SPEED
		jugador.velocity.y += jugador.GRAVITY 
		cambiar_estados()
		jugador.move_and_slide()
		jugador.animaciones()
	else:
		jugador.velocity = Vector2.ZERO
		
func cambiar_estados():
	match GlobalVar.estado_jugador:
		"Tierra":
			jugador.GRAVITY = 9.8
			jugador.SPEED = 150
			jugador.JUMP_FORCE = 250
			
			if InputBuffer.is_action_press_buffered("salto") and jugador.is_on_floor():
				jugador.velocity.y -= jugador.JUMP_FORCE
			jugador.velocity.y = clampf(jugador.velocity.y,-240,240)
		"Agua":
			jugador.GRAVITY = 5
			jugador.SPEED = 125
			jugador.JUMP_FORCE = 125
			
			if InputBuffer.is_action_press_buffered("salto"):
				jugador.velocity.y -= jugador.JUMP_FORCE
			jugador.velocity.y = clampf(jugador.velocity.y,-240,50)

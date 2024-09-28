extends Node

@export var animacion_ : AnimationPlayer

func _ready() -> void:
	animacion_.play("inico")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func cambio_anim_await_dialog(anim_cambio : String):
	await Dialogic.timeline_ended
	animacion_.play(anim_cambio)

func cambio_anim(anim_cambio : String):
	animacion_.play(anim_cambio)

func cambio_escena(Target : String):
	cambiar_escena.cambio_escena(Target)

func cambio_escena_await_dialog(Target : String):
	await Dialogic.timeline_ended
	cambiar_escena.cambio_escena(Target)

func _on_dialogic_signal(argument : String):
	if argument == "iniciar_cinematica":
		animacion_.play("aaa")

func restaurar_personaje():
	GlobalVar.vida_jugador = GlobalVar.vida_max
	GlobalVar.mana = GlobalVar.mana_max

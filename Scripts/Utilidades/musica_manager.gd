extends Node

@export var fade_duration : int
@export_enum(
"Prados","Tutorial","Castillo","Castillo_mazmorra","Catacumbas","Ciudad"
,"Ciudad_interior","Corrupcion","Creditos","Desierto","Musica_inicio","Nieve"
)
var musica_cambio : String


func _ready() -> void:
	if not musica_cambio == GlobalAudio.cancion_nom:
		GlobalAudio.cambiar_cancion(musica_cambio)
		GlobalAudio.play()
		GlobalAudio.fade_in(fade_duration)
		
	else:
		return
func _bajar_volumen():
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalAudio,"volume_db", -80, 3)
	
func _subir_volumen():
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalAudio,"volume_db", 0, 3)

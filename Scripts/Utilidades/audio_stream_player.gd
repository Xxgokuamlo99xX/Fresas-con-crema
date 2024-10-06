extends AudioStreamPlayer

var canciones : Dictionary = {
	
	"Prados" : load("res://Recursos/Sonidos/Musica/Prados.ogg"),
	"Castillo" : load("res://Recursos/Sonidos/Musica/Castillo.ogg"),
	"Castillo_mazmorra" : load("res://Recursos/Sonidos/Musica/Castillo_mazmorra.mp3"),
	"Catacumbas" : load("res://Recursos/Sonidos/Musica/Catacumbas.ogg"),
	"Ciudad" : load("res://Recursos/Sonidos/Musica/Ciudad.mp3"),
	"Ciudad_interior" : load("res://Recursos/Sonidos/Musica/Ciudad_interiores.mp3"),
	"Corrupcion" : load("res://Recursos/Sonidos/Musica/Corrupcion.ogg"),
	"Creditos" : load("res://Recursos/Sonidos/Musica/Creditos.mp3"),
	"Desierto" : load("res://Recursos/Sonidos/Musica/Desierto.mp3"),
	"Musica_inicio" : load("res://Recursos/Sonidos/Musica/Musica_inicio_2.mp3"),
	"Nieve" : load("res://Recursos/Sonidos/Musica/Nieve.ogg"),
	"Tutorial" : load("res://Recursos/Sonidos/Musica/Tutorial.mp3")
	
}
var cancion_act
var cancion_nom : String

func cambiar_cancion(Nombre : String):
	get_cancion(Nombre)
	stream = cancion_act
	
func get_cancion(Nombre_c : String):
	cancion_act = canciones[Nombre_c]
	cancion_nom = Nombre_c
	
func fade_in(duracion : float):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"volume_db", 0, duracion)

extends Node

var pausa : bool 
var char_state : String
var nivel_anterior 

var puertas_abiertas : Array 

#Jugador
var vida_jugador : int  = 100
var vida_max : int = 60
var player_damage_taken : int
var disparado_jugador : bool = false
var mana : int = 50
var mana_max : int = 100
var puede_moverse : bool = true 
var eter : int
var estado_jugador : String = "Tierra"
var multi_damage : float = 1

var enemigo_damage_taken

var boss_1_alive : bool = false
var current_boss_life : int

#FIXME Arreglar el rendimiento de esta basura
var style: DialogicStyle = load("res://Estilos_dialogic/estilo_1.tres")
	
func _enter_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Dialogic.preload_timeline("res://Timelines/Npc_1.dtl")
	style.prepare()
	
func _process(delta):
	if vida_jugador > vida_max:
		vida_jugador = vida_max
	mana = clampi(mana,0,mana_max)

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "Cerrar_juego":
		get_tree().quit()

extends Node

var pausa : bool 
var char_state : String
var nivel_anterior 

var puertas_abiertas : Array 

#Jugador
var vida_jugador = 100
var vida_max = 100
var player_damage_taken : int
var disparado_jugador : bool = false
var mana : int = 50
var mana_max : int = 100
var puede_moverse : bool = true 

var enemigo_damage_taken

var boss_1_alive : bool = false
var current_boss_life : int

var puntos : int

var monedas : int

#FIXME Arreglar el rendimiento de esta basura
var style: DialogicStyle = load("res://Estilos_dialogic/estilo_1.tres")
	
func _enter_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Dialogic.preload_timeline("res://Timelines/Npc_1.dtl")
	style.prepare()

	
func _process(delta):
	vida_jugador = clampi(vida_jugador,0,vida_max)
	mana = clampi(mana,0,mana_max)

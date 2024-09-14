extends Node

signal partida_guardada

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

var nivel_act 
var jugador_pos : Vector2 
var escena_nom
var escena_path : StringName

var enemigo_damage_taken


#FIXME Arreglar el rendimiento de esta basura
var estilo : DialogicStyle = preload("res://Estilos_dialogic/aszasasasasas/ya bsata.tres")
func _enter_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Dialogic.preload_timeline("res://Timelines/Npc_1.dtl")
	estilo.prepare()
	
func _process(delta):
	vida_jugador = clampi(vida_jugador,0,vida_max)
	mana = clampi(mana,0,mana_max)

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "Cerrar_juego":
		get_tree().quit()

func guardar_partida():
	var file = FileAccess.open("user://Archivo de guardado.json",FileAccess.WRITE)
	nivel_act = get_tree().current_scene
	escena_nom = nivel_act.name
	escena_path = nivel_act.scene_file_path
	print(escena_nom)
	jugador_pos = get_node("/root/" + escena_nom + "/Goku").position
	var datos = {
		
		"Vida" : vida_jugador,
		"vida_max" : vida_max,
		"Mana" : mana,
		"Mana_max" : mana_max,
		"path_escena" : escena_path,
		"nivel_actual" : nivel_act,
		"escena_nombre" : escena_nom,
		"posicion" : jugador_pos,
		"Eter" : eter,
		"mejora_de_damage" : multi_damage,
		"id_mision" : Ids.mision_act_id
	}
	
	var json = JSON.stringify(datos)
	file.store_string(json)
	file.close()
	partida_guardada.emit()
	
func cargar_partida():
	var file = FileAccess.open("user://Archivo de guardado.json",FileAccess.READ)
	if file == null:
		return
		
	var json = file.get_as_text()
	var datos = JSON.parse_string(json)
	var position_string = datos["posicion"]
	var parts = position_string.trim_prefix("(").trim_suffix(")").split(",")
	var x = float(parts[0])
	var y = float(parts[1])
	var position_vector = Vector2(x, y)
	print(position_vector)  # Imprime el Vector2(97.49818, 160.924)
	
	vida_jugador = datos["Vida"]
	vida_max = datos["vida_max"]
	mana = datos["Mana"]
	mana_max = datos["Mana_max"]
	escena_path = datos["path_escena"]
	nivel_act = datos["nivel_actual"]
	escena_nom = datos["escena_nombre"]
	jugador_pos = position_vector
	eter = datos["Eter"]
	multi_damage = datos["mejora_de_damage"]
	Ids.mision_act_id = datos["id_mision"]
	
	Ids.misiones_nom_resumen()
	cambiar_escena.cambio_escena(escena_path)
	await get_tree().current_scene.ready
	get_node("/root/" + escena_nom + "/Goku").set_position(jugador_pos) 
	file.close()
	

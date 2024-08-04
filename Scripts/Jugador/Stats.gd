extends CanvasLayer
var fps

func _ready():
	$".".show()
	
	
func _physics_process(delta):
	fps = Engine.get_frames_per_second()
	#FPS
	$Stats/CanvasLayer/Fps.text = "Fps: " + str(fps)
	$Stats/CanvasLayer/Estado.text = "Estado: " + str(GlobalVar.char_state)
	$Stats/CanvasLayer/puntos.text = "Puntuacion: " + str(GlobalVar.puntos)
	
	#VIDA
	$vida/Vida_vacia.size = Vector2(GlobalVar.vida_max,19)
	$vida/Vida_llena.size = Vector2(GlobalVar.vida_jugador,19)
	$vida/Label.text = str(GlobalVar.vida_jugador) + "/" + str(GlobalVar.vida_max)
	
	#MANA
	$mana/TextureProgressBar.value = GlobalVar.mana
	$mana/TextureProgressBar.max_value = GlobalVar.mana_max

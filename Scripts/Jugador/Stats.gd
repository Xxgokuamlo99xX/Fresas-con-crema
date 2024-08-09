extends CanvasLayer
var fps

func _ready():
	$".".show()
	
	
func _physics_process(delta):
	fps = Engine.get_frames_per_second()
	#FPS
	$Stats/Fps.text = "Fps: " + str(fps)
	$Stats/Eter.text = "Eter: " + str(GlobalVar.eter)
	
	#VIDA
	$vida/Vida_vacia.size = Vector2(GlobalVar.vida_max,19)
	$vida/Vida_llena.size = Vector2(GlobalVar.vida_jugador,19)
	
	#MANA
	$mana/TextureProgressBar.value = GlobalVar.mana
	$mana/TextureProgressBar.max_value = GlobalVar.mana_max

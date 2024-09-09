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
	$vida/Label.text = "Vida: " + str(GlobalVar.vida_jugador) + "/" + str(GlobalVar.vida_max)
	$vida/TextureProgressBar.value = GlobalVar.vida_jugador
	$vida/TextureProgressBar.max_value = GlobalVar.vida_max
	
	#MANA
	$mana/TextureProgressBar.value = GlobalVar.mana
	$mana/TextureProgressBar.max_value = GlobalVar.mana_max

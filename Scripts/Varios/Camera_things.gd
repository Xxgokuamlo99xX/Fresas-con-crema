extends Camera2D

@export var randomStrength: float = 10.0
@export var shakeFade: float = 5.0
var daño_acomulado = 0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func apply_shake():
	shake_strength = randomStrength

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)

		offset = randomOffset()
	#if daño_acomulado >= 20:
		#$"../efectos/AnimationPlayer".play("perder_cora")
		#daño_acomulado = 0
		

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func _on_goku_recive_damage():
	#if $"../Invulnerable".is_stopped():
		apply_shake()
		$"HUD/daño_vida".play("daño")
		#daño_acomulado += GlobalVar.player_damage_taken
	
func _on_goku_curarse() -> void:
	$"HUD/daño_vida".play("curarse")

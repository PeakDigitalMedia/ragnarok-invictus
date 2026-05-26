class_name TestDummy
extends StaticBody2D

const MAX_HEALTH := 100.0
const FLASH_DURATION := 0.12

var health := MAX_HEALTH
var _flash_timer: float = 0.0

@onready var _visual: Polygon2D = $Visual

func _process(delta: float) -> void:
	if _flash_timer > 0.0:
		_flash_timer -= delta
		if _flash_timer <= 0.0:
			_visual.color = Color(0.55, 0.55, 0.6, 1)

func take_damage(amount: float) -> void:
	health -= amount
	print("Hit! dmg=%.0f  hp=%.0f/%.0f" % [amount, health, MAX_HEALTH])
	_visual.color = Color(1.0, 0.15, 0.15, 1)
	_flash_timer = FLASH_DURATION
	if health <= 0.0:
		print("Dummy down — resetting.")
		health = MAX_HEALTH

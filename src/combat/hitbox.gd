class_name Hitbox
extends Area2D

# Collision layer 9  = player hitbox
# Collision layer 12 = enemy hurtbox
# monitorable is always false — Hitbox is the detector, never the target.

signal hit_landed(hurtbox)

@export var damage: float = 10.0
@export var knockback: Vector2 = Vector2(200.0, -80.0)

var _hit_targets: Array = []

func _ready() -> void:
	add_to_group("hitbox")
	collision_layer = 0
	set_collision_layer_value(9, true)
	collision_mask = 0
	set_collision_mask_value(12, true)
	monitoring = false
	monitorable = false
	area_entered.connect(_on_area_entered)

func activate() -> void:
	_hit_targets.clear()
	monitoring = true

func deactivate() -> void:
	monitoring = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox") and area not in _hit_targets:
		_hit_targets.append(area)
		hit_landed.emit(area)

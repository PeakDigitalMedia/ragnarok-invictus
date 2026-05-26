class_name Hurtbox
extends Area2D

# Passive damage marker — never monitors, always monitorable.
# Hitboxes detect this; damage is applied by the Hitbox owner via hit_landed.
# own_layer_bit: 12 = enemy/dummy, 10 = player

@export var own_layer_bit: int = 12

func _ready() -> void:
	add_to_group("hurtbox")
	collision_layer = 0
	set_collision_layer_value(own_layer_bit, true)
	collision_mask = 0
	monitoring = false
	monitorable = true

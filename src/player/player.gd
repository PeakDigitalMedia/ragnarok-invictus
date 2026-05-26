class_name Player
extends PlayerBase

@onready var _visuals: Node2D = $Visuals

func play_animation(anim_name: String) -> void:
	pass

func _on_facing_changed(facing_right: bool) -> void:
	_visuals.scale.x = 1.0 if facing_right else -1.0

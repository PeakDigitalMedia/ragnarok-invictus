class_name Player
extends PlayerBase

@onready var _visuals: Node2D = $Visuals
@onready var _anim_player: AnimationPlayer = $AnimationPlayer

func play_animation(anim_name: String) -> void:
	if anim_name.is_empty() or not _anim_player:
		return
	if _anim_player.has_animation(anim_name):
		_anim_player.play(anim_name)

func _on_facing_changed(facing_right: bool) -> void:
	_visuals.scale.x = 1.0 if facing_right else -1.0

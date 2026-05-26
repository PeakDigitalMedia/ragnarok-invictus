extends Node

# Registers all input actions in code so the Input Map doesn't need manual setup.
# Add gamepad events here later alongside the keyboard ones.

func _ready() -> void:
	_register("move_left",    [KEY_A, KEY_LEFT])
	_register("move_right",   [KEY_D, KEY_RIGHT])
	_register("jump",         [KEY_SPACE, KEY_W, KEY_UP])
	_register("run",          [KEY_SHIFT])
	_register("dodge",        [KEY_C])
	_register("attack_basic", [KEY_J])
	_register("attack_power", [KEY_K])

func _register(action: String, keys: Array[Key]) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
	if not InputMap.action_get_events(action).is_empty():
		return
	for key: Key in keys:
		var event := InputEventKey.new()
		event.keycode = key
		InputMap.action_add_event(action, event)

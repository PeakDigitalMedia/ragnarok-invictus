extends Node

# Keyboard + Xbox controller bindings registered in code.
# JOY_BUTTON_* and JOY_AXIS_* constants follow Godot's SDL2 mapping,
# which matches Xbox layout correctly on Windows via XInput/Bluetooth.
#
# Xbox mapping reference:
#   A=0  B=1  X=2  Y=3
#   LB=9  RB=10  LT=axis4  RT=axis5
#   Left stick: axis0 (H), axis1 (V)

func _ready() -> void:
	_add("move_left",    keys([KEY_A, KEY_LEFT]))
	_add("move_left",    axis(JOY_AXIS_LEFT_X, -1))
	_add("move_right",   keys([KEY_D, KEY_RIGHT]))
	_add("move_right",   axis(JOY_AXIS_LEFT_X, 1))
	_add("jump",         keys([KEY_SPACE, KEY_W, KEY_UP]))
	_add("jump",         button(JOY_BUTTON_A))
	_add("run",          keys([KEY_SHIFT]))
	_add("run",          button(JOY_BUTTON_LEFT_STICK))
	_add("dodge",        keys([KEY_C]))
	_add("dodge",        button(JOY_BUTTON_B))
	_add("attack_basic", keys([KEY_J]))
	_add("attack_basic", button(JOY_BUTTON_X))
	_add("attack_power", keys([KEY_K]))
	_add("attack_power", button(JOY_BUTTON_Y))


func _add(action: String, events: Array) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
	var existing := InputMap.action_get_events(action)
	for e in events:
		# Skip if an event of the same type and value is already registered
		var is_duplicate := false
		for ex in existing:
			if e.get_class() == ex.get_class() and e.as_text() == ex.as_text():
				is_duplicate = true
				break
		if not is_duplicate:
			InputMap.action_add_event(action, e)


func keys(keycodes: Array[Key]) -> Array:
	var out: Array = []
	for k in keycodes:
		var e := InputEventKey.new()
		e.keycode = k
		out.append(e)
	return out


func button(btn: JoyButton) -> Array:
	var e := InputEventJoypadButton.new()
	e.button_index = btn
	return [e]


func axis(ax: JoyAxis, direction: int) -> Array:
	var e := InputEventJoypadMotion.new()
	e.axis = ax
	e.axis_value = direction * 0.5
	return [e]

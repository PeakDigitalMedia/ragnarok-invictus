class_name TestDummy
extends CharacterBody2D

const MAX_HEALTH := 100.0
const FLASH_DURATION := 0.12

const BAR_WIDTH := 60.0
const BAR_HEIGHT := 8.0
const BAR_POS := Vector2(-30.0, -72.0)

const PATROL_SPEED := 60.0
const PATROL_DISTANCE := 80.0
const GRAVITY := 900.0

var health := MAX_HEALTH
var _flash_timer: float = 0.0
var _patrol_origin: float = 0.0
var _patrol_dir: float = 1.0

@onready var _visual: Polygon2D = $Visual

func _ready() -> void:
	_patrol_origin = global_position.x

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0.0

	velocity.x = PATROL_SPEED * _patrol_dir

	var dist := global_position.x - _patrol_origin
	if dist >= PATROL_DISTANCE and _patrol_dir > 0.0:
		_patrol_dir = -1.0
	elif dist <= -PATROL_DISTANCE and _patrol_dir < 0.0:
		_patrol_dir = 1.0

	_visual.scale.x = _patrol_dir
	move_and_slide()
	if is_on_wall():
		_patrol_dir *= -1.0

func _process(delta: float) -> void:
	if _flash_timer > 0.0:
		_flash_timer -= delta
		if _flash_timer <= 0.0:
			_visual.color = Color(0.55, 0.55, 0.6, 1)

func take_damage(amount: float) -> void:
	health = maxf(health - amount, 0.0)
	_visual.color = Color(1.0, 0.15, 0.15, 1)
	_flash_timer = FLASH_DURATION
	queue_redraw()
	if health <= 0.0:
		queue_free()

func _draw() -> void:
	var fill := health / MAX_HEALTH
	draw_rect(Rect2(BAR_POS, Vector2(BAR_WIDTH, BAR_HEIGHT)), Color(0.15, 0.15, 0.15, 0.85))
	var fill_color := Color(0.2, 0.85, 0.2) if fill > 0.5 else (Color(0.9, 0.75, 0.1) if fill > 0.25 else Color(0.9, 0.15, 0.15))
	draw_rect(Rect2(BAR_POS, Vector2(BAR_WIDTH * fill, BAR_HEIGHT)), fill_color)
	draw_rect(Rect2(BAR_POS, Vector2(BAR_WIDTH, BAR_HEIGHT)), Color(0, 0, 0, 0.8), false, 1.0)

class_name PlayerBase
extends CharacterBody2D

# Required Input Map actions:
#   move_left, move_right, jump, run, dodge

# --- Stats ---

@export_group("Movement")
@export var walk_speed: float = 220.0
@export var run_speed: float = 380.0
@export var jump_velocity: float = -560.0
@export var dodge_speed: float = 620.0
@export var dodge_duration: float = 0.18
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.12

@export_group("Resources")
@export var max_health: float = 100.0
@export var max_stamina: float = 100.0
@export var max_godforce: float = 100.0
@export var max_vordr_charge: float = 100.0
@export var max_resonance: float = 100.0

@export_group("Stamina")
@export var stamina_regen_rate: float = 22.0
@export var stamina_regen_delay: float = 1.5
@export var dodge_stamina_cost: float = 25.0
@export var run_stamina_cost: float = 12.0

# --- State ---

enum State { IDLE, WALK, RUN, JUMP, FALL, DODGE, ATTACK, HURT, DEAD }

var state: State = State.IDLE

var health: float
var stamina: float
var godforce: float
var vordr_charge: float
var resonance: float

# --- Signals ---

signal health_changed(current: float, maximum: float)
signal stamina_changed(current: float, maximum: float)
signal godforce_changed(current: float, maximum: float)
signal vordr_charge_changed(current: float, maximum: float)
signal resonance_changed(current: float, maximum: float)
signal state_changed(new_state: State)
signal died()

# --- Internals ---

var _facing_right: bool = true
var _is_invincible: bool = false
var _dodge_timer: float = 0.0
var _dodge_direction: float = 1.0
var _coyote_timer: float = 0.0
var _jump_buffer_timer: float = 0.0
var _stamina_regen_timer: float = 0.0

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# --- Lifecycle ---

func _ready() -> void:
	health = max_health
	stamina = max_stamina
	godforce = max_godforce
	vordr_charge = max_vordr_charge
	resonance = 0.0
	_on_ready()

func _physics_process(delta: float) -> void:
	match state:
		State.DODGE:
			_process_dodge(delta)
		State.DEAD:
			pass
		_:
			_apply_gravity(delta)
			_process_horizontal(delta)
			_process_jump(delta)

	_process_stamina_regen(delta)
	move_and_slide()

# --- Movement ---

func _process_horizontal(delta: float) -> void:
	if state == State.ATTACK:
		velocity.x = move_toward(velocity.x, 0.0, walk_speed * 12.0 * delta)
		return
	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0.0:
		_set_facing(direction > 0.0)

	var wants_run := Input.is_action_pressed("run") and stamina > 0.0
	var speed := run_speed if wants_run else walk_speed

	if direction != 0.0:
		velocity.x = direction * speed
		if wants_run:
			_use_stamina(run_stamina_cost * delta)
			_set_state(State.RUN)
		else:
			_set_state(State.WALK)
	else:
		velocity.x = move_toward(velocity.x, 0.0, walk_speed * 12.0 * delta)
		if is_on_floor():
			_set_state(State.IDLE)

	if Input.is_action_just_pressed("dodge") and stamina >= dodge_stamina_cost:
		var dodge_dir := direction if direction != 0.0 else (1.0 if _facing_right else -1.0)
		_start_dodge(dodge_dir)

func _process_jump(delta: float) -> void:
	if state == State.ATTACK:
		return
	if is_on_floor():
		_coyote_timer = coyote_time
	else:
		_coyote_timer -= delta

	if Input.is_action_just_pressed("jump"):
		_jump_buffer_timer = jump_buffer_time
	else:
		_jump_buffer_timer -= delta

	if _jump_buffer_timer > 0.0 and _coyote_timer > 0.0:
		velocity.y = jump_velocity
		_coyote_timer = 0.0
		_jump_buffer_timer = 0.0
		_set_state(State.JUMP)

	if not is_on_floor():
		_set_state(State.JUMP if velocity.y < 0.0 else State.FALL)

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += _gravity * delta

func _start_dodge(direction: float) -> void:
	_use_stamina(dodge_stamina_cost)
	_dodge_direction = direction
	_dodge_timer = dodge_duration
	_is_invincible = true
	_set_state(State.DODGE)

func _process_dodge(delta: float) -> void:
	velocity.x = _dodge_direction * dodge_speed
	velocity.y = 0.0
	_dodge_timer -= delta
	if _dodge_timer <= 0.0:
		_is_invincible = false
		_set_state(State.IDLE)

# --- Stamina ---

func _process_stamina_regen(delta: float) -> void:
	if _stamina_regen_timer > 0.0:
		_stamina_regen_timer -= delta
		return
	if stamina < max_stamina:
		_modify_stamina(stamina_regen_rate * delta)

func _use_stamina(amount: float) -> void:
	_stamina_regen_timer = stamina_regen_delay
	_modify_stamina(-amount)

func _modify_stamina(amount: float) -> void:
	stamina = clamp(stamina + amount, 0.0, max_stamina)
	stamina_changed.emit(stamina, max_stamina)

# --- Public API ---

func take_damage(amount: float) -> void:
	if _is_invincible or state == State.DEAD:
		return
	health = clamp(health - amount, 0.0, max_health)
	health_changed.emit(health, max_health)
	if health <= 0.0:
		_set_state(State.DEAD)
		died.emit()

func modify_godforce(amount: float) -> void:
	godforce = clamp(godforce + amount, 0.0, max_godforce)
	godforce_changed.emit(godforce, max_godforce)

func modify_vordr_charge(amount: float) -> void:
	vordr_charge = clamp(vordr_charge + amount, 0.0, max_vordr_charge)
	vordr_charge_changed.emit(vordr_charge, max_vordr_charge)

func modify_resonance(amount: float) -> void:
	resonance = clamp(resonance + amount, 0.0, max_resonance)
	resonance_changed.emit(resonance, max_resonance)

# --- State Machine ---

func _set_state(new_state: State) -> void:
	if state == new_state:
		return
	state = new_state
	state_changed.emit(state)
	play_animation(_state_to_anim(state))
	_on_state_changed(state)

func _state_to_anim(s: State) -> String:
	match s:
		State.IDLE:   return "idle"
		State.WALK:   return "walk"
		State.RUN:    return "run"
		State.JUMP:   return "jump"
		State.FALL:   return "fall"
		State.DODGE:  return "dodge"
		State.ATTACK: return "attack"
		State.HURT:   return "hurt"
		State.DEAD:   return "dead"
		_:            return "idle"

func _set_facing(facing_right: bool) -> void:
	if _facing_right == facing_right:
		return
	_facing_right = facing_right
	_on_facing_changed(facing_right)

# --- Overridable hooks for subclasses ---

func _on_ready() -> void:
	pass

func _on_state_changed(_new_state: State) -> void:
	pass

func _on_facing_changed(_facing_right: bool) -> void:
	pass

## Drive the character's AnimationPlayer or AnimationTree.
func play_animation(_anim_name: String) -> void:
	pass

class_name CombatComponent
extends Node

enum Phase { IDLE, STARTUP, ACTIVE, RECOVERY }

# Timing and damage for the 3-hit basic combo and power attack.
# Startup: wind-up before hitbox activates.
# Active:  hitbox is live.
# Recovery: post-hit window; pressing J here continues the chain.
const BASIC_ATTACKS = [
	{startup = 0.08, active = 0.10, recovery = 0.18, damage = 8.0,  stamina = 8.0,  knockback = Vector2(180, -60),  anim = "attack_1"},
	{startup = 0.07, active = 0.10, recovery = 0.16, damage = 10.0, stamina = 8.0,  knockback = Vector2(200, -60),  anim = "attack_2"},
	{startup = 0.10, active = 0.12, recovery = 0.22, damage = 15.0, stamina = 8.0,  knockback = Vector2(280, -100), anim = "attack_3"},
]
const POWER_ATTACK = {startup = 0.20, active = 0.12, recovery = 0.35, damage = 28.0, stamina = 20.0, knockback = Vector2(380, -150), anim = "attack_power"}

var phase: Phase = Phase.IDLE

var _player: PlayerBase
var _hitbox: Hitbox
var _combo_count: int = 0
var _phase_timer: float = 0.0
var _attack_buffered: bool = false
var _current_attack: Dictionary = {}

func _ready() -> void:
	_player = get_parent() as PlayerBase
	_hitbox = _player.get_node_or_null("Visuals/AttackHitbox") as Hitbox
	assert(_player != null, "CombatComponent must be a direct child of PlayerBase")
	if _hitbox:
		_hitbox.hit_landed.connect(_on_hit_landed)

func _on_hit_landed(hurtbox: Area2D) -> void:
	var target := hurtbox.get_parent()
	if target.has_method("take_damage"):
		target.take_damage(_current_attack.damage)

func _process(delta: float) -> void:
	_handle_input()
	_tick(delta)

func _handle_input() -> void:
	if Input.is_action_just_pressed("attack_basic"):
		match phase:
			Phase.IDLE:
				_start_attack(BASIC_ATTACKS[0])
			Phase.STARTUP, Phase.ACTIVE, Phase.RECOVERY:
				_attack_buffered = true

	if Input.is_action_just_pressed("attack_power"):
		if phase == Phase.IDLE:
			_start_attack(POWER_ATTACK)

func _start_attack(data: Dictionary) -> void:
	if _player.stamina < data.stamina:
		return
	_player._use_stamina(data.stamina)
	_current_attack = data
	if _hitbox:
		_hitbox.damage = data.damage
		_hitbox.knockback = data.knockback
		_hitbox.deactivate()
	_phase_timer = data.startup
	phase = Phase.STARTUP
	_player._set_state(PlayerBase.State.ATTACK)
	_player.play_animation(data.anim)

func _tick(delta: float) -> void:
	if phase == Phase.IDLE:
		return
	_phase_timer -= delta
	if _phase_timer > 0.0:
		return
	match phase:
		Phase.STARTUP:  _enter_active()
		Phase.ACTIVE:   _enter_recovery()
		Phase.RECOVERY: _finish()

func _enter_active() -> void:
	phase = Phase.ACTIVE
	_phase_timer = _current_attack.active
	if _hitbox:
		_hitbox.activate()

func _enter_recovery() -> void:
	phase = Phase.RECOVERY
	_phase_timer = _current_attack.recovery
	if _hitbox:
		_hitbox.deactivate()

func _finish() -> void:
	if _attack_buffered and _combo_count < BASIC_ATTACKS.size() - 1:
		_attack_buffered = false
		_combo_count += 1
		_start_attack(BASIC_ATTACKS[_combo_count])
	else:
		_attack_buffered = false
		_combo_count = 0
		phase = Phase.IDLE
		_player._set_state(PlayerBase.State.IDLE)

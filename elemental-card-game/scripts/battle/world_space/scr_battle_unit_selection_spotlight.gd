class_name BattleUnitSelectionSpotlight
extends Node3D

var unit: BattleUnit
var pos_target: Vector3
# Animations
var fade_t: float
var fade_t_target: float
# Components
var spotlight: SpotLight3D

# Main methods

func set_up():
	spotlight = $SpotLight3D


func _process(delta: float) -> void:
	_lerp_to_targets(delta)
	_update_position(delta)
	_animate_fade()


# Public methods

func turn_on():
	fade_t_target = 1


func turn_off():
	fade_t_target = 0
	unit = null


func toggle_focus(new_state: bool):
	pass


func set_unit(p_unit: BattleUnit):
	if !p_unit:
		return
	if unit == p_unit:
		return
	
	var new_pos: Vector3 = _get_spotlight_planar_pos(p_unit.global_position)
	if !unit:
		global_position = new_pos
		turn_on()
	unit = p_unit
	pos_target = new_pos


# Private methods

func _lerp_to_targets(delta: float):
	fade_t = UtilMath.exp_decay(fade_t, fade_t_target, 16, delta)


func _update_position(delta: float):
	global_position = UtilMath.exp_decay_vec3(global_position, pos_target, 16, delta)


func _animate_fade():
	spotlight.spot_angle = lerpf(0, 20, fade_t)


# Util

func _get_spotlight_planar_pos(pos: Vector3) -> Vector3:
	return Vector3(pos.x, 5, pos.z)

class_name BattleHandCard
extends Node2D

enum State {
	IDLE,
	HOVERED,
	SELECTED,
}

var state: State
var is_hovered: bool
var is_selected: bool
## This card's position in the hand.
var hand_index: int
# Animations
var hand_position_t: float
var hand_position_t_target: float
var hovered_offset: float
var hovered_offset_target: float
var selected_scale: float
var selected_scale_target: float
# Components
var rig: Node2D
var card: GameCard

# Main methods

func set_up(card_data: Card):
	rig = $Rig
	card = MainManager.card_manager.create_card(card_data)
	
	rig.add_child(card)
	
	selected_scale_target = 1.0
	selected_scale = selected_scale_target


func _process(delta: float) -> void:
	_lerp_to_target(delta)
	_update_hand_position()
	_update_selected_scale()


# Public methods

func set_hovered_state(new_state: bool):
	is_hovered = new_state
	_update_lerp_targets()


func set_selected_state(new_state: bool):
	is_selected = new_state
	_update_lerp_targets()


# Private methods

func _lerp_to_target(delta: float):
	hand_position_t = UtilMath.exp_decay(hand_position_t, hand_position_t_target, 8, delta)
	hovered_offset = UtilMath.exp_decay(hovered_offset, hovered_offset_target, 16, delta)
	selected_scale = UtilMath.exp_decay(selected_scale, selected_scale_target, 16, delta)


func _update_hand_position():
	# Update the base position
	var hand_card_container: BattleHandCardContainer = BattleManager.hand_manager.hand_card_container
	var t: float = hand_position_t
	
	var angle: float = -0.5 * PI + lerpf(-hand_card_container.angle_range * PI, hand_card_container.angle_range * PI, t)
	
	global_position = \
		hand_card_container.circle_origin \
		+ hand_card_container.circle_radius * Vector2(cos(angle), sin(angle))
	
	# Guard against division by zero
	if (hand_card_container.circle_origin - global_position).length() > 0.001:
		look_at(hand_card_container.circle_origin)
	
	rotate(-0.5 * PI)
	
	# Update the hovered position
	var hovered_offset_vec: Vector2 = hovered_offset * transform.y
	global_position += hovered_offset_vec


func _update_selected_scale():
	rig.scale = Vector2.ONE * selected_scale


func _update_lerp_targets():
	if is_selected:
		# State: SELECTED
		hovered_offset_target = -20
		selected_scale_target = 1.1
		return
	
	if is_hovered:
		# State: HOVERED
		hovered_offset_target = -20
		selected_scale_target = 1.0
	else:
		# State: IDLE
		hovered_offset_target = 0
		selected_scale_target = 1.0

class_name BattleHandCardContainer
extends Node2D

## This value is owned by HandManager and is passed here by reference.
var card_list: Array[BattleHandCard]
var hovered_card_index: int
var circle_origin: Vector2

@export var circle_radius: float = 700 # debug_data[0]
@export var circle_y_offset: float = 600 # debug_data[1]
@export var angle_range: float = 0.07 # debug_data[2] 

# Main methods

func set_up(p_card_list: Array[BattleHandCard]):
	card_list = p_card_list
	
	_update_position()
	
	# Signals
	get_tree().root.size_changed.connect(_update_position)
	BattleManager.hand_manager.hand_updated.connect(_update_card_positions)
	BattleManager.hand_manager.card_hovered.connect(_on_card_hovered)


# Public methods

func add_card(new_card: BattleHandCard):
	add_child(new_card)
	_update_card_positions()


# Private methods

func _update_position():
	var viewport_size: Vector2 = get_viewport().size
	global_position = Vector2(viewport_size.x / 2, viewport_size.y)
	circle_origin = to_global(Vector2(0, circle_y_offset))
	
	_update_card_positions()


func _update_card_positions():
	var card_count: int = card_list.size()
	for i in card_count:
		var card: BattleHandCard = card_list[i]
		var t: float = float(i) / float(card_count - 1)
		
		# Push neighboring cards away.
		if abs(i - hovered_card_index) < 2:
			t += 0.02 * (i - hovered_card_index)
			pass
		
		card.hand_position_t_target = t


# Signals

func _on_card_hovered(_hovered_card: BattleHandCard, p_hovered_card_index: int):
	hovered_card_index = p_hovered_card_index
	_update_card_positions()

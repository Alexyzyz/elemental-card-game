class_name HandManager
extends Node

signal hand_updated
signal card_hovered(hovered_card: BattleHandCard, hovered_card_index: int)
signal card_selected(selected_card: BattleHandCard, selected_card_index: int)

var card_list: Array[BattleHandCard]
var hand_card_container: BattleHandCardContainer
var hovered_card: BattleHandCard
var selected_card: BattleHandCard
# Debug
var debug_printer_dot_products: Label

# Main methods

func set_up(p_hand_card_container: BattleHandCardContainer):
	hand_card_container = p_hand_card_container
	
	debug_printer_dot_products = MainManager.debug_manager.create_debug_printer()
	
	hand_card_container.set_up(card_list)


func _process(_delta: float) -> void:
	_update_hovered_card()
	_handle_select_card_input()


# Public methods

func add_card(new_card: BattleHandCard):
	card_list.push_back(new_card)
	new_card.hand_index = card_list.size() - 1
	hand_card_container.add_card(new_card)
	hand_updated.emit()


func remove_card():
	for i in card_list.size():
		var card: BattleHandCard = card_list[i]
		card.hand_index = i
	hand_updated.emit()


func unselect_card():
	if !selected_card:
		return
	selected_card.set_selected_state(false)
	selected_card = null


# Private methods

func _handle_select_card_input():
	if !Input.is_action_just_pressed("game_cursor_primary"):
		return
	if !hovered_card:
		return
	
	# Set this card as the selected one.
	if hovered_card != selected_card:
		if selected_card:
			selected_card.set_selected_state(false)
		
		hovered_card.set_selected_state(true)
		selected_card = hovered_card
		card_selected.emit(selected_card, selected_card.hand_index)
		return
	
	# Un-select that card instead.
	unselect_card()
	card_selected.emit(null, -1)


func _update_hovered_card():
	var hand_origin: Vector2 = hand_card_container.circle_origin
	var cursor_to_hand_vec_unnormal: Vector2 = MainManager.cursor_pos - hand_origin
	
	if cursor_to_hand_vec_unnormal.length() > hand_card_container.circle_radius + 75:
		if hovered_card:
			hovered_card.set_hovered_state(false)
			hovered_card = null
			card_hovered.emit(null, -1)
		return
	
	var cursor_to_hand_vec: Vector2 = cursor_to_hand_vec_unnormal.normalized()
	
	var closest_card: Dictionary = {
		"card": null,
		"dot_product": -1,
	}
	
	for card in card_list:
		var card_to_hand_vec: Vector2 = (card.global_position - hand_origin).normalized()
		var dot_product: float = cursor_to_hand_vec.dot(card_to_hand_vec)
		
		if dot_product > closest_card.dot_product:
			closest_card.card = card
			closest_card.dot_product = dot_product
	
	if closest_card.card == hovered_card:
		return
	
	if hovered_card:
		hovered_card.set_hovered_state(false)
	
	if closest_card.card:
		hovered_card = closest_card.card
		closest_card.card.set_hovered_state(true)
		card_hovered.emit(hovered_card, closest_card.card.hand_index)

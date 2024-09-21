class_name HandManager
extends Node

signal hand_updated
signal card_hovered(hovered_card: BattleHandCard, hovered_card_index: int)

var card_list: Array[BattleHandCard]
var hand_card_container: BattleHandCardContainer
var hovered_card: BattleHandCard
# Debug
var debug_printer_dot_products: Label

# Main methods

func set_up(p_hand_card_container: BattleHandCardContainer):
	hand_card_container = p_hand_card_container
	
	debug_printer_dot_products = MainManager.debug_manager.create_debug_printer()
	
	hand_card_container.set_up(card_list)


func _process(delta: float) -> void:
	_update_hovered_card()
	pass


# Public methods

func add_card(new_card: BattleHandCard):
	card_list.push_back(new_card)
	hand_card_container.add_card(new_card)
	hand_updated.emit()


func remove_card():
	hand_updated.emit()


# Private methods

func _update_hovered_card():
	var hand_origin: Vector2 = hand_card_container.circle_origin
	var cursor_to_hand_vec: Vector2 = (MainManager.cursor_pos - hand_origin).normalized()
	
	var closest_card: Dictionary = {
		"card": null,
		"index": -1,
		"dot_product": -1,
	}
	
	var card_index: int = 0
	for card in card_list:
		var card_to_hand_vec: Vector2 = (card.global_position - hand_origin).normalized()
		var dot_product: float = cursor_to_hand_vec.dot(card_to_hand_vec)
		
		if dot_product > closest_card.dot_product:
			closest_card.card = card
			closest_card.index = card_index
			closest_card.dot_product = dot_product
		
		card_index += 1
	
	if closest_card.card == hovered_card:
		return
	
	if hovered_card:
		hovered_card.set_hovered_state(false)
	
	if closest_card.card:
		hovered_card = closest_card.card
		closest_card.card.set_hovered_state(true)
		card_hovered.emit(hovered_card, closest_card.index)

class_name CardManager
extends Node

# Public methods

func create_card(card_data: Card) -> GameCard:
	var new_card: GameCard = MainManager.load_manager.prefabs.game_card.instantiate()
	new_card.set_up(card_data)
	return new_card


func create_hand_card(card_data: Card) -> BattleHandCard:
	var new_card: BattleHandCard = MainManager.load_manager.prefabs.battle_hand_card.instantiate()
	new_card.set_up(card_data)
	return new_card

class_name LoadManagerPrefabs
extends Node

static var game_card: PackedScene

static var battle_unit: PackedScene
static var battle_hand_card: PackedScene
static var battle_buildup_indicator: PackedScene
static var battle_buildup_indicator_slot: PackedScene
static var battle_buildup_indicator_container: PackedScene

static var debug_label: PackedScene

# Main methods

func set_up():
	game_card = load("res://prefabs/game/prefab_game_card.tscn")
	
	battle_unit = load("res://prefabs/battle/prefab_battle_unit.tscn")
	battle_hand_card = load("res://prefabs/battle/prefab_battle_hand_card.tscn")
	battle_buildup_indicator = load("res://prefabs/battle/prefab_battle_buildup_indicator.tscn")
	battle_buildup_indicator_slot = load("res://prefabs/battle/prefab_battle_buildup_indicator_slot.tscn")
	battle_buildup_indicator_container = load("res://prefabs/battle/prefab_battle_buildup_indicator_container.tscn")
	
	debug_label = load("res://prefabs/debug/prefab_debug_label.tscn")

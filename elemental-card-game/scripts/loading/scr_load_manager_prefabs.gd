class_name LoadManagerPrefabs
extends Node

static var battle_unit: PackedScene
static var battle_buildup_indicator: PackedScene
static var battle_buildup_indicator_slot: PackedScene
static var battle_buildup_indicator_container: PackedScene

# Main methods

func set_up():
	battle_unit = load("res://prefabs/prefab_battle_unit.tscn")
	battle_buildup_indicator = load("res://prefabs/prefab_battle_buildup_indicator.tscn")
	battle_buildup_indicator_slot = load("res://prefabs/prefab_battle_buildup_indicator_slot.tscn")
	battle_buildup_indicator_container = load("res://prefabs/prefab_battle_buildup_indicator_container.tscn")

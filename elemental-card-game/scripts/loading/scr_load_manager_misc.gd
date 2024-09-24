class_name LoadManagerMisc
extends Node

static var env_battle: Environment
static var env_battle_unit_selection: Environment

# Main methods

func set_up():
	env_battle = load("res://environments/env_battle.tres")
	env_battle_unit_selection = load("res://environments/env_battle_unit_selection.tres")

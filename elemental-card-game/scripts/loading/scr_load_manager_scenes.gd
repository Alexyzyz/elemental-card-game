class_name LoadManagerScenes
extends Node

static var battle: PackedScene

# Main methods

func set_up():
	battle = load("res://scenes/scene_battle.tscn")

class_name BattleManager
extends Node3D

static var ally_list: Array[BattleUnit]
static var opponent_list: Array[BattleUnit]
# Important nodes
static var camera: Camera3D
static var parent_3d: Node3D
static var parent_2d: Node2D
static var parent_control: Control
static var parent_ally: Node3D
static var parent_opponent: Node3D

# Main methods

func _ready() -> void:
	_set_up()
	_set_up_battle()


func _set_up():
	camera = get_viewport().get_camera_3d()
	parent_3d = $Node3D
	parent_2d = $Node2D
	parent_control = $Control
	
	parent_ally = parent_3d.get_node("ParentAlly")
	parent_opponent = parent_3d.get_node("ParentOpponent")


func _set_up_battle():
	var ally: BattleUnit = MainManager.load_manager.prefabs.battle_unit.instantiate()
	parent_ally.add_child(ally)
	
	ally_list.push_back(ally)
	ally.set_up()


func _process(_delta: float) -> void:
	_handle_debug_input()


# Debugging

func _handle_debug_input():
	if !Input.is_action_pressed("debug_toggle"):
		return
	
	if Input.is_action_just_pressed("debug_0"):
		ally_list[0].buildup_indicator_container.buildup_indicator_list[0].increment_buildup(1)
	
	if Input.is_action_just_pressed("debug_1"):
		ally_list[0].buildup_indicator_container.buildup_indicator_list[0].increment_buildup(-1)

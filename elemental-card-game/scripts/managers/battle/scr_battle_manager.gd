class_name BattleManager
extends Node3D

static var ally_list: Array[BattleUnit]
static var opponent_list: Array[BattleUnit]
# Managers
static var hand_manager: HandManager
# Important nodes
static var camera: Camera3D
static var parent_3d: Node3D
static var parent_2d: Node2D
static var parent_control: Control
static var parent_ally: Node3D
static var parent_opponent: Node3D

@export var test_card: Card

# Main methods

func _ready() -> void:
	_set_up()
	_set_up_battle()
	
	_populate_hand()


func _set_up():
	hand_manager = $HandManager
	camera = get_viewport().get_camera_3d()
	parent_3d = $Node3D
	parent_2d = $Node2D
	parent_control = $Control
	
	# 3D
	parent_ally = parent_3d.get_node("ParentAlly")
	parent_opponent = parent_3d.get_node("ParentOpponent")
	#2D
	var hand_card_container: BattleHandCardContainer = parent_2d.get_node("HandCardContainer")
	
	# Set everything up
	hand_manager.set_up(hand_card_container)


func _set_up_battle():
	var ally: BattleUnit = MainManager.load_manager.prefabs.battle_unit.instantiate()
	parent_ally.add_child(ally)
	
	ally_list.push_back(ally)
	ally.set_up()


func _populate_hand():
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))


func _process(_delta: float) -> void:
	_handle_debug_input()

# Public methods



# Debugging

func _handle_debug_input():
	if !Input.is_action_pressed("debug_toggle"):
		return
	
	if Input.is_action_just_pressed("debug_0"):
		ally_list[0].buildup_indicator_container.buildup_indicator_list[0].increment_buildup(1)
	
	if Input.is_action_just_pressed("debug_1"):
		ally_list[0].buildup_indicator_container.buildup_indicator_list[0].increment_buildup(-1)

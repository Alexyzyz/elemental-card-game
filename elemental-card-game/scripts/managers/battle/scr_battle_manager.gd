class_name BattleManager
extends Node3D

enum State {
	IDLE,
	SELECTING_TARGET,
}

static var state: State
static var ally_list: Array[BattleUnit]
static var opponent_list: Array[BattleUnit]
static var hovered_unit: BattleUnit
# Managers
static var hand_manager: HandManager
# Important nodes
static var unit_selection_spotlight: BattleUnitSelectionSpotlight
static var camera: Camera3D
static var directional_light: DirectionalLight3D
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
	directional_light = parent_3d.get_node("DirectionalLight3D")
	unit_selection_spotlight = parent_3d.get_node("UnitSelectionSpotlight")
	# 2D
	var hand_card_container: BattleHandCardContainer = parent_2d.get_node("HandCardContainer")
	
	# Set everything up
	hand_manager.set_up(hand_card_container)
	unit_selection_spotlight.set_up()
	
	# Signals
	hand_manager.card_selected.connect(_on_card_selected)


func _set_up_battle():
	_spawn_units(3, parent_ally, ally_list)
	_spawn_units(2, parent_opponent, opponent_list)


func _populate_hand():
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))
	hand_manager.add_card(MainManager.card_manager.create_hand_card(test_card))


func _process(_delta: float) -> void:
	_handle_debug_input()
	
	match state:
		State.IDLE:
			pass
		State.SELECTING_TARGET:
			_handle_state_selecting_target()


func _physics_process(delta: float) -> void:
	_cast_ray(delta)


# Public methods


# Private methods

func _cast_ray(_delta: float):
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var cursor_pos: Vector2 = MainManager.cursor_pos
	
	var from: Vector3 = camera.project_ray_origin(cursor_pos)
	var to: Vector3 = from + 1000 * camera.project_ray_normal(cursor_pos)
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = true
	
	var result: Dictionary = space_state.intersect_ray(query)
	_handle_raycast_result(result)


func _handle_raycast_result(result: Dictionary):
	if !result:
		return
	var parent_or_null = result.collider.get_parent()
	if !parent_or_null:
		return
	var parent: Node3D = parent_or_null
	
	if parent.is_in_group("unit"):
		_on_unit_hovered(parent)


func _spawn_units(unit_count: int, unit_parent: Node3D, unit_list: Array[BattleUnit]):
	for i in unit_count:
		var unit: BattleUnit = MainManager.load_manager.prefabs.battle_unit.instantiate()
		unit_parent.add_child(unit)
		
		unit_list.push_back(unit)
		unit.set_up()
		
		var t: float = float(i) / float(unit_count)
		var angle: float = 0.4 * PI + lerpf(0, 2 * PI, t)
		var unit_pos := 1.5 * Vector3(cos(angle), 0, sin(angle))
		unit.position = unit_pos


func _state_goto_idle():
	state = State.IDLE
	camera.environment = MainManager.load_manager.misc.env_battle
	directional_light.light_energy = 0.25
	hand_manager.unselect_card()
	unit_selection_spotlight.turn_off()


func _state_goto_selecting_target():
	state = State.SELECTING_TARGET
	camera.environment = MainManager.load_manager.misc.env_battle_unit_selection
	directional_light.light_energy = 0.1


# States

func _handle_state_selecting_target():
	if !Input.is_action_just_pressed("game_cursor_primary"):
		return
	if !hovered_unit:
		return
	
	hovered_unit \
		.buildup_indicator_container \
		.buildup_indicator_list.pick_random() \
		.increment_buildup(randi_range(1, 3))
	
	_state_goto_idle()


# Signals

func _on_unit_hovered(unit: BattleUnit):
	hovered_unit = unit
	
	if state == State.SELECTING_TARGET:
		unit_selection_spotlight.set_unit(unit)


func _on_card_selected(selected_card: BattleHandCard, selected_card_index: int):
	if selected_card:
		_state_goto_selecting_target()
	else:
		_state_goto_idle()


# Debugging

func _handle_debug_input():
	if !Input.is_action_pressed("debug_toggle"):
		return
	
	if Input.is_action_just_pressed("debug_0"):
		ally_list[0].buildup_indicator_container.buildup_indicator_list[0].increment_buildup(1)
	
	if Input.is_action_just_pressed("debug_1"):
		ally_list[0].buildup_indicator_container.buildup_indicator_list[0].increment_buildup(-1)

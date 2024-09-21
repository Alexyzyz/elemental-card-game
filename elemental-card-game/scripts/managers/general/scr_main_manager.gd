class_name MainManager
extends Node

static var cursor_pos: Vector2
static var viewport_center: Vector2
# Managers
static var load_manager: LoadManager
static var card_manager: CardManager
static var debug_manager: DebugManager
# Important nodes
static var active_scene: Node3D

var parent_active_scene: Node3D
var parent_debug: Control

# Main methods

func _ready() -> void:
	_set_up()
	_goto_battle()


func _set_up():
	load_manager = $LoadManager
	card_manager = $CardManager
	debug_manager = $DebugManager
	
	parent_active_scene = $ParentActiveScene
	parent_debug = $ParentDebug
	
	load_manager.set_up()
	debug_manager.set_up(parent_debug)


func _process(_delta: float) -> void:
	cursor_pos = get_viewport().get_mouse_position()
	viewport_center = get_viewport().size / 2
	
	debug_manager.update(_delta)


# Private methods

func _goto_battle():
	if active_scene:
		active_scene.queue_free()
	
	var new_scene: Node3D = load_manager.scenes.battle.instantiate()
	parent_active_scene.add_child(new_scene)
	active_scene = new_scene

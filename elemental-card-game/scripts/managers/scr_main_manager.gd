class_name MainManager
extends Node

static var load_manager: LoadManager
static var active_scene: Node3D

var parent_active_scene: Node3D

# Main methods

func _ready() -> void:
	_set_up()
	_goto_battle()


func _set_up():
	load_manager = $LoadManager
	parent_active_scene = $ParentActiveScene
	
	load_manager.set_up()


# Private methods

func _goto_battle():
	if active_scene:
		active_scene.queue_free()
	
	var new_scene: Node3D = load_manager.scenes.battle.instantiate()
	parent_active_scene.add_child(new_scene)
	active_scene = new_scene

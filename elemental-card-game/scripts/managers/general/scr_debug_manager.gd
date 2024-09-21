class_name DebugManager
extends Node

var printer_list: Array[Label]
# Important nodes
var parent_debug: DebugParent
# Debug textures
var debug_texture_hamburger: Control

@export var show_viewport_center: bool

# Main methods

func set_up(p_parent_debug: Control):
	parent_debug = p_parent_debug
	debug_texture_hamburger = parent_debug.get_node("DebugTextureHamburger")


func update(_delta: float):
	parent_debug.show_viewport_center = show_viewport_center


# Public methods

func create_debug_printer() -> Label:
	var new_printer: Label = MainManager.load_manager.prefabs.debug_label.instantiate()
	new_printer.name = "DebugLabel"
	parent_debug.add_child(new_printer)
	
	printer_list.push_back(new_printer)
	new_printer.global_position = Vector2(10, 10 + (printer_list.size() - 1) * 50)
	
	return new_printer

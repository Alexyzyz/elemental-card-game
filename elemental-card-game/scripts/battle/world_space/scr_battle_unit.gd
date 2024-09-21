class_name BattleUnit
extends Node3D

var health: int
var health_max: int
# Screen-space nodes
var buildup_indicator_container: BattleBuildupIndicatorContainer

# Main methods

func set_up():
	buildup_indicator_container = MainManager.load_manager.prefabs.battle_buildup_indicator_container.instantiate()
	BattleManager.parent_2d.add_child(buildup_indicator_container)
	
	buildup_indicator_container.set_up(self)


func _process(_delta: float) -> void:
	# _debug_follow_mouse()
	pass


# Debugging

func _debug_follow_mouse():
	var cam: Camera3D = BattleManager.camera
	var origin: Vector3 = cam.project_ray_origin(MainManager.cursor_pos)
	var direction: Vector3 = cam.project_ray_normal(MainManager.cursor_pos)
	
	var plane := Plane(Vector3.UP, 0)
	var planar_pos = plane.intersects_ray(origin, direction)
	
	if planar_pos == null:
		return
	global_position = planar_pos

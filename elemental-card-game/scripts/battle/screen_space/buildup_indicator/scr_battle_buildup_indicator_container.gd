class_name BattleBuildupIndicatorContainer
extends Node2D

var unit: BattleUnit
var buildup_indicator_list: Array[BattleBuildupIndicator]

# Main methods

func set_up(p_unit: BattleUnit):
	unit = p_unit
	
	for value in Element.ElementType.values():
		var buildup_indicator: BattleBuildupIndicator = MainManager.load_manager.prefabs.battle_buildup_indicator.instantiate()
		add_child(buildup_indicator)
		
		buildup_indicator_list.push_back(buildup_indicator)
		buildup_indicator.set_up(self, value)
		
		var angle_t: float = float(value) / float(Element.ElementType.values().size() - 1)
		var angle: float = -.5 * PI + lerpf(-0.15 * PI, 0.15 * PI, angle_t)
		buildup_indicator.position = 100 * Vector2(cos(angle), sin(angle))


func _process(_delta: float) -> void:
	_update_position()


# Private methods

func _update_position():
	var screen_pos: Vector2 = \
		BattleManager.camera.unproject_position(unit.global_position + 0.5 * Vector3.UP)
	global_position = screen_pos

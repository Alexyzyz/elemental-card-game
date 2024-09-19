class_name BattleUnit
extends Node3D

var buildup_indicator_container: BattleBuildupIndicatorContainer

# Main methods

func set_up():
	buildup_indicator_container = MainManager.load_manager.prefabs.battle_buildup_indicator_container.instantiate()
	BattleManager.parent_2d.add_child(buildup_indicator_container)
	
	buildup_indicator_container.set_up(self)

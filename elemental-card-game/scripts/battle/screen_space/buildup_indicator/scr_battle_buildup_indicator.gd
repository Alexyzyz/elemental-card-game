class_name BattleBuildupIndicator
extends Node2D

const BUILDUP_PER_TIER: int = 3
const SLOT_POSITION_RADIUS: float = 6

var container: BattleBuildupIndicatorContainer
var element: Element.ElementType
var buildup: int
var slot_list: Array[BattleBuildupIndicatorSlot]

# Main methods

func set_up(p_container: BattleBuildupIndicatorContainer, p_element: Element.ElementType):
	container = p_container
	element = p_element
	
	for i in BUILDUP_PER_TIER:
		var slot: BattleBuildupIndicatorSlot = MainManager.load_manager.prefabs.battle_buildup_indicator_slot.instantiate()
		add_child(slot)
		
		slot_list.push_back(slot)
		slot.set_up(Element.ELEMENT_COLOR[element])
		
		var angle: float = -.5 * PI + lerpf(0, 2 * PI, float(i) / float(BUILDUP_PER_TIER))
		slot.position = SLOT_POSITION_RADIUS * Vector2(cos(angle), sin(angle))
	
	_update_slots()


# Public methods

func increment_buildup(increment: int):
	buildup = clampi(buildup + increment, 0, 3 * BUILDUP_PER_TIER)
	_update_slots()


# Private methods

func _update_slots():
	var tier: int = floor(float(buildup) / 3.0)
	var overflow_index: int = buildup % 3
	
	for i in slot_list.size():
		var slot: BattleBuildupIndicatorSlot = slot_list[i]
		slot.set_tier(tier + 1 if i < overflow_index else tier)

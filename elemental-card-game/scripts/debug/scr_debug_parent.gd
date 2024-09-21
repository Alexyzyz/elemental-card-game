class_name DebugParent
extends Control

var show_viewport_center: bool

# Main methods

func _process(delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	if show_viewport_center:
		var viewport_size: Vector2 = get_viewport().size
		var viewport_center: Vector2 = MainManager.viewport_center
		
		var hor_from := Vector2(0, viewport_center.y)
		var hor_to := Vector2(viewport_size.x, viewport_center.y)
		var ver_from := Vector2(viewport_center.x, 0)
		var ver_to := Vector2(viewport_center.x, viewport_size.y)
		
		draw_line(hor_from, hor_to, Color.ORANGE, 1)
		draw_line(ver_from, ver_to, Color.ORANGE, 1)

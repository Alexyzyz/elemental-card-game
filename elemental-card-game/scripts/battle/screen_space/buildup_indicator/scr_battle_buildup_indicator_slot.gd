class_name BattleBuildupIndicatorSlot
extends Node2D

const SPARK_SCALE_TO_TIER: Array[float] = [0, 0.5, 1.0, 1.5]

var tier: int = 0
# Children
var spark: Node2D
var spark_sprite: Sprite2D

# Main methods

func set_up(color: Color):
	spark = $Spark
	spark_sprite = $Spark/Sprite2D_Spark
	
	spark_sprite.self_modulate = color


# Public methods

func set_tier(p_tier: int):
	tier = clampi(p_tier, 0, 3)
	
	spark.visible = (tier != 0)
	spark.scale = SPARK_SCALE_TO_TIER[tier] * Vector2.ONE

class_name GameCard
extends Node2D

var card_data: Card
# Components
var art_sprite: Sprite2D
var damage_label: Label
var buildup_label: Label

# Main method

func set_up(p_card_data: Card):
	art_sprite = $Rig/Sprite2D_Art
	damage_label = $Rig/Label_Damage
	buildup_label = $Rig/Label_Buildup
	
	card_data = p_card_data
	
	# art_sprite.texture = card_data.art_texture
	damage_label.text = str(card_data.base_damage)
	buildup_label.text = str(card_data.base_buildup)

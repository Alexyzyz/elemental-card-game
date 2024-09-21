class_name Card
extends Resource
## Custom resource. Contains the data of a card from the game.

@export var art_texture: Texture2D
@export var title: String
@export_multiline var description: String
@export_multiline var flavor_text: String
@export var base_damage: int
@export var base_buildup: int

@tool
@icon("res://addons/brennys-game-manager/icons/abstract_hud/AbstractHudIcon.svg")
extends TextureRect
class_name AbstractHudIcon

@export var filled_texture : Texture2D
@export var empty_texture : Texture2D
@export var icon_type : StringName

# swap to the empty texture
func swap_to_empty_texture():
	texture = empty_texture
	
# swap to the filled texture
func swap_to_filled_texture():
	texture = filled_texture

func update_icon(player: Player):
	var stat_node = player.get_stat_node_by_string_name(icon_type)
	var stat_value = stat_node.stat_value
	var icon_index = get_parent().get_children().find(self) + 1
	if icon_index <= stat_value: 
		swap_to_filled_texture()
	else:
		swap_to_empty_texture()

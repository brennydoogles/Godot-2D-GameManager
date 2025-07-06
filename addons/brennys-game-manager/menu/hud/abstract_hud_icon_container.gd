@icon("res://addons/brennys-game-manager/icons/abstract_hud/AbstractHudIconContainer.svg")
extends AspectRatioContainer
class_name AbstractHudIconContainer

@export var icon_scene : PackedScene
@export var icon_type_name : StringName

#node where the icons will be added to the scene
@export var icons_parent_node : Control

func _ready():
	#	remove development icons
	for icon in get_all_icons():
		icon.free()
			
func get_all_icons() -> Array[Node]:
	return icons_parent_node.get_children()
	
func initalize_icons(player: AbstractPlayer):
	for stat_node in player.stat_nodes:
		if icon_type_name == stat_node.stat_name:
			for stat_value in stat_node.max_stat_value:
				var new_icon : AbstractHudIcon = icon_scene.instantiate()
				icons_parent_node.add_child(new_icon)
				new_icon.update_icon(player)
				
func update_all_icon_children(player: AbstractPlayer):
	for icon : AbstractHudIcon in icons_parent_node.get_children():
		icon.update_icon(player)

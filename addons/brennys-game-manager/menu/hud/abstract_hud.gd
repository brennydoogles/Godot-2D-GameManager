@icon("res://addons/brennys-game-manager/icons/abstract_hud/AbstractHud.svg")
extends CanvasLayer
class_name AbstractHud

@export var player : AbstractPlayer
#assign the inner most control node where your icons are meant to be added to the scene
@export var abstract_container_nodes : Array[AbstractHudIconContainer]

func _ready():
	player.item_collected.connect(handle_item_collected)
	for container in abstract_container_nodes:
		container.initalize_icons(player)

func find_related_container_parent_node(container_type: StringName) -> AbstractHudIconContainer:
	for container in abstract_container_nodes:
		if container.icon_type_name == container_type:
			return container
	return null

func handle_item_collected(whichItem: StringName):
	var container : AbstractHudIconContainer = find_related_container_parent_node(whichItem)
	container.update_all_icon_children(player)

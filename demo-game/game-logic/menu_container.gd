@tool
extends CanvasLayer
class_name MenuContainer

func _ready():
	map_menus()
	
func map_menus():
	for menu : AbstractMenu in get_children():
		AbstractGameManager.menu_map.set(menu.menu_name, menu)

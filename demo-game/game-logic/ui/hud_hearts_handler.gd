extends AbstractHud
class_name HeartAbstractHud

@onready var heart_container : HeartController = $Control/MarginContainer/PanelContainer/HeartContainer

func _ready():
	heart_container.set_hearts_to_new_value(0, hud_value)

func respond_to_heart_pickup(itemName, itemValue):
	if itemName == 'hearts':
		hud_value += itemValue

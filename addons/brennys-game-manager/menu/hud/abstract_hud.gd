@icon("res://addons/brennys-game-manager/icons/abstract_hud/AbstractHud.svg")
extends CanvasLayer
class_name AbstractHud

signal hud_value_updated(oldValue, newValue)

@export var hud_value_name : StringName = ''

@export var hud_value: int = 0:
	set(newValue):
		var oldValue = hud_value
		hud_value = newValue
		hud_value_updated.emit(oldValue, newValue)

@icon("res://addons/brennys-game-manager/icons/AbstractHudDataProvider.svg")
class_name AbstractHudDataProvider
extends Node

@export var trackedValueName: String
var value

func _ready() -> void:
	GameStateEvents.HUD_VALUE_UPDATED.connect(_on_hud_value_updated)

func _on_hud_value_updated(valueName, newValue) -> void:
	if(valueName == trackedValueName):
		value = newValue

func get_value_as(type: Variant):
	assert(is_instance_of(value, type), "The referenced HUD variable " + trackedValueName + " is not of type " + str(type))
	return value

func get_value_as_string() -> String:
	if value:
		return str(value)
	return ""
func get_value_as_int() -> int:
	if value:
		assert(typeof(value) == TYPE_INT, "The referenced HUD variable " + trackedValueName + " is not an int")
		return int(value)
	return 0
func get_value_as_float() -> int:
	if value:
		assert(typeof(value) == TYPE_FLOAT, "The referenced HUD variable " + trackedValueName + " is not a float")
		return float(value)
	return 0.0
	
func get_value_as_bool() -> int:
	if value:
		assert(typeof(value) == TYPE_BOOL, "The referenced HUD variable " + trackedValueName + " is not a boolean")
		return bool(value)
	return false

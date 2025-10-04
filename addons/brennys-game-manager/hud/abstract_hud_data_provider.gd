@icon("res://addons/brennys-game-manager/icons/AbstractHudDataProvider.svg")
class_name AbstractHudDataProvider
extends Node

@export var trackedValueName: String
@export var value: Variant

func _ready() -> void:
	GameStateEvents.HUD_VALUE_UPDATED.connect(_on_hud_value_updated)

func _on_hud_value_updated(valueName, newValue) -> void:
	if(valueName == trackedValueName):
		value = newValue

func get_value_as(type: Variant.Type):
	assert(is_instance_of(value, type), "The referenced HUD variable " + trackedValueName + " is not of type " + str(type))
	return value

@icon("res://addons/brennys-game-manager/icons/AbstractMenu.svg")
class_name AbstractMenu
extends Control

@export var menu_name : StringName

func _enter_tree() -> void:
	GameStateEvents.MENU_OPEN.emit()

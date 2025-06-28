@icon("uid://cev1cg7epg2ok")
class_name AbstractMenu
extends Control

func _enter_tree() -> void:
	GameStateEvents.MENU_OPEN.emit()

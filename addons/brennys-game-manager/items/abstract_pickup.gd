@icon("res://addons/brennys-game-manager/icons/abstract_pickup/AbstractPickup.svg")
extends Area2D
class_name AbstractPickup

@export var item_type : StringName

func _on_area_entered(_area):
	queue_free()

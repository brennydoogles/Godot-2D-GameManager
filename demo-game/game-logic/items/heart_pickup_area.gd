extends Area2D
class_name HeartPickupArea

@export var item_name : StringName = 'hearts'
@export var item_value : int = 1

func _on_pickup_area_area_entered(_area):
	queue_free()

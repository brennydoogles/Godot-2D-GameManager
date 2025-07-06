extends Node
class_name AbstractStat

@export var stat_value : int
@export var max_stat_value : int
@export var stat_cap : int = 10
@export var stat_name : StringName

signal stat_depleted

func increase_stat(by_how_much: int):
	print(stat_name, stat_value)
	stat_value = clamp(stat_value + by_how_much, 0, max_stat_value)
	print(stat_name, stat_value)
func decrease_stat(by_how_much: int):
	stat_value = clamp(stat_value - by_how_much, 0, max_stat_value)
	check_if_stat_depleted()
	
func check_if_stat_depleted():
	if stat_value <= 0:
		stat_depleted.emit()
	

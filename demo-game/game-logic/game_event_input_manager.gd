extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_pressed("pause"):
		GameStateEvents.SHOW_MENU_REQUESTED.emit("pause_menu")

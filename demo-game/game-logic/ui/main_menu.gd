extends AbstractMenu



func _on_quit_button_pressed() -> void:
	get_tree().quit(0)


func _on_play_button_pressed() -> void:
	print("Play Button Pressed")
	GameStateEvents.LEVEL_CHANGE_REQUESTED.emit(GlobalConstants.LEVEL_MAP.get("test"))

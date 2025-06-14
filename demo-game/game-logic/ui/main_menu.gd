extends AbstractMenu



func _on_quit_button_pressed() -> void:
	get_tree().quit(0)


func _on_play_button_pressed() -> void:
	GameStateEvents.LEVEL_CHANGE_REQUESTED.emit("test_level")
	GameStateEvents.CLOSE_MENU_REQUESTED.emit()

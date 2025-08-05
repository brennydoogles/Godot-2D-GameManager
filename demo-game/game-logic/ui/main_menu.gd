extends AbstractMenu



func _on_quit_button_pressed() -> void:
	get_tree().quit(0)


func _on_play_button_pressed() -> void:
	GameStateEvents.LEVEL_CHANGE_REQUESTED.emit("test_level", "fade_to_black", Vector2(0,0))
	GameStateEvents.CLOSE_MENU_REQUESTED.emit()

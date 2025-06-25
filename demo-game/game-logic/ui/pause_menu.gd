extends AbstractMenu

func _on_resume_button_pressed() -> void:
	GameStateEvents.CLOSE_MENU_REQUESTED.emit()


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)

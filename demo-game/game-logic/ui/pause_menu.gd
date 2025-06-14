extends AbstractMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_button_pressed() -> void:
	GameStateEvents.CLOSE_MENU_REQUESTED.emit()


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)

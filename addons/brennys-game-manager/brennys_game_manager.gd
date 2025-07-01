@tool
extends EditorPlugin

const AUTOLOADS: Dictionary[String, String] = {
	"GameStateEvents": "res://addons/brennys-game-manager/event-bus/game-state-events.gd"
	}


func _enable_plugin() -> void:
	for key in AUTOLOADS:
		add_autoload_singleton(key, AUTOLOADS.get(key))

func _disable_plugin() -> void:
	for key in AUTOLOADS:
		remove_autoload_singleton(key)

extends Node

var elapsed_seconds: int = 0

func _ready() -> void:
	GameStateEvents.HUD_VALUE_UPDATED.emit("hud_timer_time", elapsed_seconds)

func _on_timer_timeout() -> void:
	elapsed_seconds += 1
	GameStateEvents.HUD_VALUE_UPDATED.emit("hud_timer_time", elapsed_seconds)

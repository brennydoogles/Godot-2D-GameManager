@icon("res://addons/brennys-game-manager/icons/AbstractHud.svg")
class_name AbstractHud
extends Control

@export var data_provider: AbstractHudDataProvider
@export var hudName: String

func _on_ready() -> void:
	GameStateEvents.HIDE_HUD_REQUESTED.connect(handle_hide_hud_requested)

func handle_hide_hud_requested(requestedHud: String) -> void:
	if(requestedHud == hudName):
		self.queue_free()
